import 'dart:async';
import 'dart:developer';

import 'package:verymemo/common/barrel/model_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:image_picker/image_picker.dart';

final memoWritingViewModelProvider =
    StateNotifierProvider<MemoWritingViewModel, MemoWritingState>((ref) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  final userNotifier = ref.watch(userProvider.notifier);
  return MemoWritingViewModel(memoNotifier, userNotifier);
});

class MemoWritingViewModel extends StateNotifier<MemoWritingState> {
  static bool _isFirstLaunch = true; // 최초 실행 여부를 체크하는 static 변수
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

    // 최초 실행시에만 라이팅 뷰 열기
    if (_isFirstLaunch) {
      state = state.copyWith(
        visible: true,
        isExpanded: true,
      );
      state.focusNode.requestFocus();
      _isFirstLaunch = false; // 다음부터는 자동으로 열리지 않도록 설정
    } else {
      state = state.copyWith(
        visible: false,
        isExpanded: false,
      );
    }
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
      buttonState: (text.isNotEmpty ||
              state.selectedImages.isNotEmpty ||
              state.links.isNotEmpty)
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
        final newPaths = result.files
            .where((file) => file.path != null)
            .map((file) => file.path!)
            .toList();

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
          buttonState: ButtonState.primary,
        );

        log("---> 상태 업데이트 후 links 길이: ${state.links.length}");
      } catch (e) {
        log("---> 메타데이터 fetch 실패: $e");
        final newLink = LinkModel(linkUrl: url, metaTitle: url);

        final newState = state.copyWith(
          links: [...state.links, newLink], // spread operator로 새 리스트 생성
          showLinkInput: true,
          isExpanded: true,
          buttonState: ButtonState.primary,
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
      final text = state.textController.text.trim();

      log("---> 메모 저장 시작");
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

      if (text.isNotEmpty ||
          state.selectedImages.isNotEmpty ||
          state.links.isNotEmpty) {
        final memoModel = MemoModel(
          userId: userId,
          content: text,
          images: state.selectedImages
              .map((e) => ImageModel(
                    imageUrl: e,
                    description: 'internal_storage',
                  ))
              .toList(),
          links: state.links, // 링크 데이터는 그대로 전달
          tags: [],
          createdAt: DateTime.now(),
          updatedAt: null,
          isLocalMemo: true,
          isBookMarked: false,
        );

        log("---> MemoModel 생성 완료");
        // 저장된 링크 데이터 확인
        for (var link in memoModel.links ?? []) {
          log("---> 저장된 링크 정보:");
          log("     URL: ${link.linkUrl}");
          log("     썸네일: ${link.thumbnail}");
          log("     제목: ${link.metaTitle}");
          log("     설명: ${link.metaDescription}");
        }

        await memoProvider.addMemo(memoModel);
        log("---> 메모 저장 완료!");
      }
    } catch (e, stackTrace) {
      log("---> 메모 저장 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      rethrow;
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
          buttonState: ButtonState.primary,
        );
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
}
