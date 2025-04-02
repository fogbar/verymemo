import 'dart:async';
import 'dart:developer';

import 'package:verymemo/common/barrel/model_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoEditViewModelProvider = StateNotifierProvider.family<
    MemoEditViewModel, MemoWritingState, MemoModel>((ref, memo) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  final userNotifier = ref.watch(userProvider.notifier);
  return MemoEditViewModel(memoNotifier, userNotifier, memo);
});

class MemoEditViewModel extends StateNotifier<MemoWritingState> {
  final MemoNotifier memoProvider;
  final UserNotifier userProvider;
  final MemoModel originalMemo;
  Timer? _debounce;

  MemoEditViewModel(
    this.memoProvider,
    this.userProvider,
    this.originalMemo,
  ) : super(MemoWritingState()) {
    // 초기 상태 설정
    state.textController.text = originalMemo.content ?? '';
    state.selectedImages =
        originalMemo.images?.map((e) => e.imageUrl ?? '').toList() ?? [];
    state.links = originalMemo.links ?? [];

    // 버튼 상태 업데이트
    _updateButtonState();

    // 리스너 등록
    state.textController.addListener(_onTextChanged);
    state.linkController.addListener(_onLinkChanged);
  }

  @override
  void dispose() {
    state.textController.dispose();
    state.linkController.dispose();
    state.textController.removeListener(_onTextChanged);
    state.linkController.removeListener(_onLinkChanged);
    super.dispose();
  }

  /// 텍스트 변경 감지 - 버튼 상태용
  void _onTextChanged() {
    final text = state.textController.text.trim();
    _updateButtonState();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      log("---> onTextChanged: $text");
      state = state.copyWith(
        debouncedText: text,
      );
    });
  }

  /// 버튼 상태 업데이트
  void _updateButtonState() {
    final text = state.textController.text.trim();
    final hasChanges = text != (originalMemo.content ?? '') ||
        state.selectedImages.length != (originalMemo.images?.length ?? 0) ||
        state.links.length != (originalMemo.links?.length ?? 0);

    state = state.copyWith(
      buttonState: hasChanges ? ButtonState.primary : ButtonState.disabled,
    );
  }

  /// 링크 입력 감지
  void _onLinkChanged() {
    final text = state.linkController.text.trim();
    if (_isValidUrl(text)) {
      state = state.copyWith(
        buttonState: ButtonState.primary,
      );
    }
  }

  bool _isValidUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.scheme == 'http' || uri.scheme == 'https';
    } catch (e) {
      return false;
    }
  }

  /// 이미지 선택
  Future<void> pickImages(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        allowCompression: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final newPaths = result.files
            .where((file) => file.path != null)
            .map((file) => file.path!)
            .toList();

        state = state.copyWith(
          selectedImages: [...state.selectedImages, ...newPaths],
        );
        _updateButtonState();
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  /// 카메라로 사진 촬영
  Future<void> takePicture(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        state = state.copyWith(
          selectedImages: [...state.selectedImages, image.path],
        );
        _updateButtonState();
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('사진 촬영 중 오류가 발생했습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// [링크 추가]
  Future<void> setLinks(BuildContext context) async {
    state = state.copyWith(
      showLinkInput: !state.showLinkInput,
    );

    if (state.showLinkInput) {
      state.linkFocusNode.requestFocus(); // 링크 입력 필드로 포커스 이동
    }
  }

  /// 링크 추가
  Future<void> addLink(BuildContext context) async {
    log("---> 체크 버튼 클릭됨");
    final url = state.linkController.text.trim();
    log("---> 입력된 URL: $url");
    log("---> 현재 links 길이: ${state.links.length}");

    if (_isValidUrl(url) && !state.links.any((link) => link.linkUrl == url)) {
      try {
        final metadata = await AnyLinkPreview.getMetadata(
          link: url,
          cache: const Duration(days: 7),
        );

        // 썸네일 URL 검증
        String? thumbnailUrl = metadata?.image;
        if (thumbnailUrl != null) {
          if (!_isValidUrl(thumbnailUrl) ||
              thumbnailUrl.startsWith('file://')) {
            thumbnailUrl = null;
          }
        }

        final newLink = LinkModel(
          linkUrl: url,
          metaTitle: metadata?.title ?? url,
          metaDescription: metadata?.desc,
          thumbnail: thumbnailUrl, // 검증된 썸네일 URL만 저장
        );

        log("---> 생성된 newLink: ${newLink.toJson()}");

        final newLinks = [...state.links, newLink];
        log("---> 업데이트될 links 길이: ${newLinks.length}");

        state = state.copyWith(
          links: newLinks,
          showLinkInput: true,
          isExpanded: true,
        );
        _updateButtonState();

        log("---> 상태 업데이트 후 links 길이: ${state.links.length}");
      } catch (e) {
        log("---> 메타데이터 fetch 실패: $e");
        final newLink = LinkModel(linkUrl: url, metaTitle: url);

        final newState = state.copyWith(
          links: [...state.links, newLink], // spread operator로 새 리스트 생성
          showLinkInput: true,
          isExpanded: true,
        );
        _updateButtonState();

        state = newState; // 상태 업데이트
      }
      state.linkController.clear();
    }
  }

  /// 이미지 삭제
  void removeImage(int index) {
    final updatedImages = List<String>.from(state.selectedImages);
    updatedImages.removeAt(index);
    state = state.copyWith(selectedImages: updatedImages);
    _updateButtonState();
  }

  /// 링크 삭제
  void removeLink(int index) {
    final updatedLinks = List<LinkModel>.from(state.links);
    updatedLinks.removeAt(index);
    state = state.copyWith(links: updatedLinks);
    _updateButtonState();
  }

  /// 메모 업데이트
  Future<void> updateMemo(BuildContext context) async {
    try {
      final text = state.textController.text.trim();

      log("---> 메모 업데이트 시작");
      log("---> 텍스트: $text");
      log("---> 이미지: ${state.selectedImages}");

      // 링크 데이터 상세 로깅
      for (var link in state.links) {
        log("---> 저장할 링크 정보:");
        log("     URL: ${link.linkUrl}");
        log("     썸네일: ${link.thumbnail}");
        log("     제목: ${link.metaTitle}");
        log("     설명: ${link.metaDescription}");
      }

      final updatedMemo = originalMemo.copyWith(
        content: text,
        images: state.selectedImages
            .map((e) => ImageModel(
                  imageUrl: e,
                  description: 'internal_storage',
                ))
            .toList(),
        links: state.links,
        updatedAt: DateTime.now(),
      );

      log("---> MemoModel 업데이트 완료");

      await memoProvider.updateMemo(updatedMemo);
      log("---> 메모 업데이트 완료!");

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e, stackTrace) {
      log("---> 메모 업데이트 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      rethrow;
    }
  }
}
