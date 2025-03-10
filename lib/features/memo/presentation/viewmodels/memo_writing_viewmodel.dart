import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_view.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_writing_state.dart';

final memoWritingViewModelProvider =
    StateNotifierProvider<MemoWritingViewModel, MemoWritingState>((ref) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  final userNotifier = ref.watch(userProvider.notifier);
  // final writingMenuStateNotifier = ref.watch(writingMenuStateProvider.notifier);
  return MemoWritingViewModel(memoNotifier, userNotifier);
});

class MemoWritingViewModel extends StateNotifier<MemoWritingState> {
  final MemoNotifier memoProvider;
  final UserNotifier userProvider;
  // final WritingMenuState writingMenuState;
  Timer? _debounce;

  MemoWritingViewModel(
    this.memoProvider,
    this.userProvider,
    // this.writingMenuState,
  ) : super(MemoWritingState()) {
    state.textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    state.textController.dispose();
    state.textController.removeListener(_onTextChanged);
    super.dispose();
  }

  /// 텍스트 변경 감지
  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      final text = state.textController.text.trim();
      state = state.copyWith(
        debouncedText: text,
        buttonState:
            text.isNotEmpty ? ButtonState.primary : ButtonState.disabled,
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
        final paths = result.files
            .where((file) => file.path != null)
            .map((file) => file.path!)
            .toList();

        state =
            state.copyWith(selectedImages: [...state.selectedImages, ...paths]);
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  /// 이미지 삭제
  void removeImage(int index) {
    final updatedImages = List<String>.from(state.selectedImages);
    updatedImages.removeAt(index);
    state = state.copyWith(selectedImages: updatedImages);
  }

  void toggle() {
    state = state.copyWith(
      visible: !state.visible,
    );
  }

  /// 작성 창 확장
  void expandWriting(BuildContext context) {
    if (!context.mounted) return;

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenHeight = mediaQuery.size.height;
    final double keyboardHeight = mediaQuery.viewInsets.bottom;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: screenHeight - keyboardHeight - mediaQuery.padding.top,
        child: const MemoWritingView(),
      ),
    );
  }

  /// 작성 창 닫기
  void closeWriting(BuildContext context) {
    state = state.copyWith(
      visible: !state.visible,
      debouncedText: "",
      textController: TextEditingController(),
      selectedImages: [],
      buttonState: ButtonState.disabled,
    );
  }

  /// 업로드 처리
  Future<void> onUploadTab(BuildContext context) async {
    await saveMemo();
    state = state.copyWith();
    if (context.mounted) closeWriting(context);
  }

  /// 메모 데이터 저장
  Future<void> saveMemo() async {
    try {
      final userId = userProvider.getUser()?.id ?? "UnKwon User";
      final memoModel = MemoModel(
        userId: userId,
        content: state.debouncedText,
        images:
            state.selectedImages.map((e) => ImageModel(imageUrl: e)).toList(),
        links: [],
        tags: [],
        createdAt: DateTime.now(),
        updatedAt: null,
        isLocalMemo: true,
        isBookMarked: false,
      );
      await memoProvider.addMemo(memoModel);
      log("---> 메모 저장 완료! $userId");
    } catch (e) {
      log("---> 메모 저장 실패: $e");
    }
  }
}
