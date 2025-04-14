import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/utils/image_compresion_util.dart';
import 'package:verymemo/externals/firebase/firebase_storage_helpder.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verymemo/features/memo/domain/caches/images_cache.dart';
import 'package:verymemo/features/memo/domain/mappers/mapper.dart';

final memoEditViewModelProvider = StateNotifierProvider.family<
    MemoEditViewModel, MemoWritingState, MemoModel>((ref, memo) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  final userNotifier = ref.watch(userProvider.notifier);
  return MemoEditViewModel(memoNotifier, userNotifier, memo, ref);
});

class MemoEditViewModel extends StateNotifier<MemoWritingState> {
  final MemoNotifier memoProvider;
  final UserNotifier userProvider;
  final MemoModel originalMemo;
  final StateNotifierProviderRef ref;
  Timer? _debounce;

  MemoEditViewModel(
    this.memoProvider,
    this.userProvider,
    this.originalMemo,
    this.ref,
  ) : super(MemoWritingState()) {
    // 초기 상태 설정
    state.textController.text = originalMemo.content ?? '';
    state.selectedImages =
        originalMemo.images?.map((e) => e.imageUrl ?? '').toList() ?? [];
    state.links = originalMemo.links ?? [];

    // 초기 버튼 상태를 비활성화로 설정
    state = state.copyWith(
      buttonState: ButtonState.disabled,
    );

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
    if (!state.textController.text.isNotEmpty) {
      state = state.copyWith(
        buttonState: ButtonState.disabled,
      );
      return;
    }

    final text = state.textController.text.trim();
    log("---> _onTextChanged 호출됨");
    log("---> 현재 텍스트: $text");
    log("---> 현재 이미지 수: ${state.selectedImages.length}");
    log("---> 현재 링크 수: ${state.links.length}");
    log("---> 현재 버튼 상태: ${state.buttonState}");

    // 즉시 버튼 상태 업데이트
    final hasContent = text.isNotEmpty ||
        state.selectedImages.isNotEmpty ||
        state.links.isNotEmpty;

    log("---> hasContent: $hasContent");
    log("---> 새로운 버튼 상태: ${hasContent ? ButtonState.primary : ButtonState.disabled}");

    state = state.copyWith(
      buttonState: hasContent ? ButtonState.primary : ButtonState.disabled,
    );

    // 디바운스는 텍스트 저장에만 사용
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      log("---> 디바운스 후 텍스트 저장: $text");
      state = state.copyWith(
        debouncedText: text,
      );
    });
  }

  /// 버튼 상태 업데이트
  void _updateButtonState() {
    final text = state.textController.text.trim();
    final hasTextChanged = text != originalMemo.content;
    final hasImagesChanged =
        state.selectedImages.length != (originalMemo.images?.length ?? 0);
    final hasLinksChanged =
        state.links.length != (originalMemo.links?.length ?? 0);

    // 이미지 URL 비교
    bool hasImageUrlsChanged = false;
    if (state.selectedImages.length == (originalMemo.images?.length ?? 0)) {
      for (int i = 0; i < state.selectedImages.length; i++) {
        if (state.selectedImages[i] != originalMemo.images?[i].imageUrl) {
          hasImageUrlsChanged = true;
          break;
        }
      }
    } else {
      hasImageUrlsChanged = true;
    }

    // 링크 내용 비교
    bool hasLinkContentsChanged = false;
    if (state.links.length == (originalMemo.links?.length ?? 0)) {
      for (int i = 0; i < state.links.length; i++) {
        if (state.links[i].linkUrl != originalMemo.links?[i].linkUrl ||
            state.links[i].metaTitle != originalMemo.links?[i].metaTitle ||
            state.links[i].metaDescription !=
                originalMemo.links?[i].metaDescription) {
          hasLinkContentsChanged = true;
          break;
        }
      }
    } else {
      hasLinkContentsChanged = true;
    }

    final hasChanges = hasTextChanged ||
        hasImagesChanged ||
        hasImageUrlsChanged ||
        hasLinksChanged ||
        hasLinkContentsChanged;

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
  // Future<void> pickImages(BuildContext context) async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: true,
  //       allowCompression: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       final newPaths = result.files
  //           .where((file) => file.path != null)
  //           .map((file) => file.path!)
  //           .toList();

  //       state = state.copyWith(
  //         selectedImages: [...state.selectedImages, ...newPaths],
  //       );
  //       _updateButtonState();
  //     }
  //   } catch (e) {
  //     debugPrint('Error picking images: $e');
  //   }
  // }

  Future<void> pickImages(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        allowCompression: true,
      );

      if (result != null && result.files.isNotEmpty) {
        // 이미지 개수 제한 (예: 최대 10개)
        if (state.selectedImages.length + result.files.length > 10) {
          if (context.mounted) {
            /// TODO: 사라님 여기 UI 확인 필요
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('이미지는 최대 10개까지 첨부할 수 있습니다.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
          return;
        }

        // 이미지 압축 진행 중 표시
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('이미지 압축 중...'),
              duration: Duration(seconds: 1),
            ),
          );
        }

        final newFiles = result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();

        // 임시 저장소에 이미지 추가
        for (final file in newFiles) {
          final compressedFile =
              await ImageCompressionUtil.compressAndResizeImage(file);
          // Firebase Storage에 임시 이미지 업로드
          final tempUrl = await FirebaseStorageHelper.uploadImageWithProgress(
            compressedFile,
            originalMemo.userId ?? Uuid().v4(),
            onProgress: (progress) {
              // 업로드 진행률 표시
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('이미지 업로드 중... ${progress.toStringAsFixed(1)}%'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
          );
          // 임시 이미지 정보 저장
          await memoProvider.addTempImage(
            originalMemo.userId ?? Uuid().v4(),
            compressedFile,
            tempUrl: tempUrl.toString(),
          );
        }

        state = state.copyWith(
          selectedImages: [
            ...state.selectedImages,
            ...newFiles.map((f) => f.path)
          ],
        );
        _updateButtonState();
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미지 선택 중 오류가 발생했습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
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
  Future<void> removeImage(BuildContext context, int index) async {
    try {
      final updatedImages = List<String>.from(state.selectedImages);
      final removedImagePath = updatedImages[index];
      updatedImages.removeAt(index);

      // 임시 이미지 캐시에서도 삭제
      final tempImages = ImagesCache.getTempImages(originalMemo.userId ?? "");
      if (tempImages != null) {
        final fileToRemove = tempImages.firstWhere(
          (file) => file.path == removedImagePath,
          orElse: () => File(''),
        );

        if (fileToRemove.existsSync()) {
          try {
            await fileToRemove.delete();
          } catch (e) {
            log('임시 이미지 파일 삭제 실패: $e');
          }
        }
      }

      state = state.copyWith(selectedImages: updatedImages);
      // MemoNotifier에서 임시 이미지 제거
      memoProvider.clearTempImages(removedImagePath);
      _updateButtonState();
    } catch (e) {
      log('이미지 삭제 중 오류 발생: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미지 삭제 중 오류가 발생했습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
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
      log("---> 원본 메모 ID: ${originalMemo.memoId}");

      // 원본 메모의 ID가 null인지 확인
      if (originalMemo.memoId == null) {
        log("---> 원본 메모 ID가 null입니다!");
        throw Exception("메모 ID가 존재하지 않습니다.");
      }

      // 링크 데이터 상세 로깅
      for (var link in state.links) {
        log("---> 저장할 링크 정보:");
        log("     URL: ${link.linkUrl}");
        log("     썸네일: ${link.thumbnail}");
        log("     제목: ${link.metaTitle}");
        log("     설명: ${link.metaDescription}");
      }

      // 메모 ID를 문자열로 변환하여 저장
      final memoId = originalMemo.memoId.toString();
      log("---> 메모 ID를 문자열로 변환: $memoId");

      final currentTime = DateTime.now();
      log("---> 현재 시간: $currentTime");

      // 1. 임시 이미지 처리
      List<ImageModel> allImages = [...originalMemo.images ?? []];

      // 새로 선택된 이미지가 있는 경우 Firebase에 업로드
      if (state.selectedImages.isNotEmpty) {
        final newFiles =
            state.selectedImages.map((path) => File(path)).toList();
        final newImageModels = await ImageMapper.prepareImageModelsForMemo(
          newFiles,
          originalMemo.userId ?? "",
        );
        allImages.addAll(newImageModels);
      }

      final updatedMemo = MemoModel(
        memoId: int.parse(memoId), // 문자열을 다시 정수로 변환
        userId: originalMemo.userId,
        content: text,
        // images: state.selectedImages
        //     .map((e) => ImageModel(
        //           imageUrl: e,
        //           description: 'internal_storage',
        //         ))
        //     .toList(),
        images: allImages,
        links: state.links,
        tags: originalMemo.tags,
        createdAt: originalMemo.createdAt,
        updatedAt: currentTime, // 현재 시간으로 명시적으로 설정
        isLocalMemo: originalMemo.isLocalMemo,
        isBookMarked: originalMemo.isBookMarked,
        lastViewedAt: originalMemo.lastViewedAt,
      );

      log("---> MemoModel 업데이트 완료");
      log("---> 업데이트된 메모 ID: ${updatedMemo.memoId}");
      log("---> 업데이트된 메모 내용: ${updatedMemo.content}");
      log("---> 업데이트된 이미지 수: ${updatedMemo.images?.length ?? 0}");
      log("---> 업데이트된 링크 수: ${updatedMemo.links?.length ?? 0}");
      log("---> 업데이트된 메모의 updatedAt: ${updatedMemo.updatedAt}");

      log("---> memoProvider.updateMemo 호출 전");
      await memoProvider.updateMemo(updatedMemo);
      log("---> memoProvider.updateMemo 호출 완료");

      // 메모 목록 새로고침
      log("---> memoProvider.getAllMemos 호출 전");
      await memoProvider.getAllMemos();
      log("---> memoProvider.getAllMemos 호출 완료");

      /// 임시 이미지 정리
      ImagesCache.clearTempImages(originalMemo.userId ?? "");

      log("---> 메모 업데이트 완료!");

      log("---> memoProvider.getAllMemos 호출 전");
      await memoProvider.getAllMemos();
      log("---> memoProvider.getAllMemos 호출 완료");

      if (context.mounted) {
        // 메모 상세 화면으로 이동
        log("---> 상세 화면으로 이동: /detail/${updatedMemo.memoId}");
        Navigator.pop(context); // 수정 화면만 닫기

        // 약간의 딜레이 후 스낵바 표시
        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('메모가 업데이트되었습니다.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
      }
    } catch (e, stackTrace) {
      log("---> 메모 업데이트 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      rethrow;
    }
  }
}
