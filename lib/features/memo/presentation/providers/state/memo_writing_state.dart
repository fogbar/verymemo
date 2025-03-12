import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';

class MemoWritingState {
  final List<String> selectedImages;
  final bool visible;
  final TextEditingController textController;
  final TextEditingController linkController;
  final FocusNode focusNode;
  final String debouncedText;
  final ButtonState buttonState;
  final bool autofocus;

  MemoWritingState({
    this.selectedImages = const [],
    this.visible = false,
    TextEditingController? textController,
    TextEditingController? linkController,
    FocusNode? focusNode,
    this.debouncedText = "",
    this.buttonState = ButtonState.disabled,
    this.autofocus = true,
  })  : textController = textController ?? TextEditingController(),
        linkController = linkController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode();

  /// 상태 복제 메서드
  MemoWritingState copyWith({
    List<String>? selectedImages,
    bool? visible,
    TextEditingController? textController,
    TextEditingController? linkController,
    FocusNode? focusNode,
    String? debouncedText,
    ButtonState? buttonState,
    bool? autofocus,
  }) {
    return MemoWritingState(
      selectedImages: selectedImages ?? this.selectedImages,
      visible: visible ?? this.visible,
      textController: textController ?? this.textController,
      linkController: linkController ?? this.linkController,
      focusNode: focusNode ?? this.focusNode,
      debouncedText: debouncedText ?? this.debouncedText,
      buttonState: buttonState ?? this.buttonState,
      autofocus: autofocus ?? this.autofocus,
    );
  }

  /// Opacity 계산
  double get opacity => visible ? 1.0 : 0.0;
}
