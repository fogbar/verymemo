import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:verymemo/common/barrel/model_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:any_link_preview/any_link_preview.dart';

final memoWritingViewModelProvider =
    StateNotifierProvider<MemoWritingViewModel, MemoWritingState>((ref) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  final userNotifier = ref.watch(userProvider.notifier);
  return MemoWritingViewModel(memoNotifier, userNotifier);
});

class MemoWritingViewModel extends StateNotifier<MemoWritingState> {
  final MemoNotifier memoProvider;
  final UserNotifier userProvider;
  Timer? _debounce;

  MemoWritingViewModel(
    this.memoProvider,
    this.userProvider,
    // this.writingMenuState,
  ) : super(MemoWritingState()) {
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
    state = state.copyWith(
      buttonState: (text.isNotEmpty || state.selectedImages.isNotEmpty)
          ? ButtonState.primary
          : ButtonState.disabled,
    );
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      log("---> onTextChanged: $text");
      state = state.copyWith(
        debouncedText: text,
      );
    });
  }

  /// 텍스트 업데이트
  void updateText(String text) {
    state.textController.text = text;
    state = state.copyWith(debouncedText: text);
  }

  /// 뒤로가기 처리
  Future<bool> onWillPop() async {
    state = state.copyWith(visible: false);
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
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
        final appDir = await getApplicationDocumentsDirectory();
        final imageDir = Directory('${appDir.path}/memo_images');
        if (!await imageDir.exists()) {
          await imageDir.create(recursive: true);
        }

        final newPaths = <String>[];
        for (var file in result.files) {
          if (file.path != null) {
            final fileName =
                '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path!)}';
            final newPath = '${imageDir.path}/$fileName';

            // 이미지를 앱 전용 디렉토리로 복사
            await File(file.path!).copy(newPath);
            newPaths.add(newPath);
          }
        }

        state = state.copyWith(
          selectedImages: [...state.selectedImages, ...newPaths],
          buttonState: ButtonState.primary,
        );
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
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

        final newLink = LinkModel(
          linkUrl: url,
          metaTitle: metadata?.title ?? url,
          metaDescription: metadata?.desc,
          thumbnail: metadata?.image,
        );

        log("---> 생성된 newLink: ${newLink.toJson()}");

        final newLinks = [...state.links, newLink];
        log("---> 업데이트될 links 길이: ${newLinks.length}");

        state = state.copyWith(
          links: newLinks,
          showLinkInput: true,
          isExpanded: true,
        );

        log("---> 상태 업데이트 후 links 길이: ${state.links.length}");
      } catch (e) {
        log("---> 메타데이터 fetch 실패: $e");
        final newLink = LinkModel(linkUrl: url, metaTitle: url);

        final newState = state.copyWith(
          links: [...state.links, newLink], // spread operator로 새 리스트 생성
          showLinkInput: true,
          isExpanded: true,
        );

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
  }

  /// 링크 삭제
  void removeLink(int index) {
    final updatedLinks = List<LinkModel>.from(state.links);
    updatedLinks.removeAt(index);
    state = state.copyWith(links: updatedLinks);
  }

  void toggle() {
    state = state.copyWith(
      visible: !state.visible,
    );

    if (state.visible) {
      // visible이 true로 바뀌면
      state.focusNode.requestFocus(); // 포커스 요청
    }
  }

  /// 작성 창 확장
  void expandWriting(BuildContext context) {
    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
      ),
      builder: (context) => const MemoWritingView(),
    );
  }

  /// 확장 상태 설정
  void setExpanded(bool expanded) {
    state = state.copyWith(isExpanded: expanded);
  }

  /// 작성 창 닫기
  void closeWriting(BuildContext context) {
    state = state.copyWith(
      visible: !state.visible,
      debouncedText: "",
      selectedImages: [],
      links: [],
      buttonState: ButtonState.disabled,
    );
    state.textController.clear();
    state.linkController.clear();
  }

  /// 업로드 처리
  Future<void> onUploadTab(BuildContext context) async {
    await saveMemo();
    if (context.mounted) closeWriting(context);
  }

  /// 메모 데이터 저장
  Future<void> saveMemo() async {
    try {
      final userId = userProvider.getUser()?.id ?? "1";
      log("---> 메모 저장 시작");
      log("---> 텍스트: ${state.debouncedText}");
      log("---> 이미지: ${state.selectedImages}");
      log("---> 링크: ${state.links}");

      final memoModel = MemoModel(
        userId: userId,
        content: state.debouncedText,
        images: state.selectedImages
            .map((e) => ImageModel(
                  imageUrl: e,
                  description: 'internal_storage',
                ))
            .toList(),
        links: state.links,
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: null,
        isLocalMemo: true,
        isBookMarked: false,
      );

      log("---> MemoModel 생성 완료: $memoModel");
      await memoProvider.addMemo(memoModel);
      log("---> 메모 저장 완료! ${memoModel.toJson()}");
    } catch (e, stackTrace) {
      log("---> 메모 저장 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      rethrow;
    }
  }
}
