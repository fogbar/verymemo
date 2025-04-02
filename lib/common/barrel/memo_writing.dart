import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

export 'package:verymemo/features/memo/presentation/components/writing_menu_bar/writing_menu_bar.dart';
export 'package:verymemo/features/memo/presentation/viewmodels/memo_writing_viewmodel.dart';
export 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
export 'package:verymemo/features/memo/presentation/providers/state/memo_writing_state.dart';
export 'package:verymemo/features/memo/presentation/memo_writing_view.dart';
export 'package:verymemo/features/memo/presentation/components/memo_list/link_view.dart';
export 'package:verymemo/features/memo/presentation/components/memo_list/molicure/link_preview.dart';

class MemoWritingState {
  final TextEditingController textController;
  final TextEditingController linkController;
  final FocusNode focusNode;
  final FocusNode linkFocusNode;
  final bool visible;
  final bool isExpanded;
  final bool showLinkInput;
  final String debouncedText;
  List<String> selectedImages;
  List<LinkModel> links;
  final ButtonState buttonState;
  final double opacity;

  MemoWritingState({
    TextEditingController? textController,
    TextEditingController? linkController,
    FocusNode? focusNode,
    FocusNode? linkFocusNode,
    this.visible = false,
    this.isExpanded = false,
    this.showLinkInput = false,
    this.debouncedText = '',
    this.selectedImages = const [],
    this.links = const [],
    this.buttonState = ButtonState.disabled,
    this.opacity = 1.0,
  })  : textController = textController ?? TextEditingController(),
        linkController = linkController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode(),
        linkFocusNode = linkFocusNode ?? FocusNode();

  MemoWritingState copyWith({
    TextEditingController? textController,
    TextEditingController? linkController,
    FocusNode? focusNode,
    FocusNode? linkFocusNode,
    bool? visible,
    bool? isExpanded,
    bool? showLinkInput,
    String? debouncedText,
    List<String>? selectedImages,
    List<LinkModel>? links,
    ButtonState? buttonState,
    double? opacity,
  }) {
    return MemoWritingState(
      textController: textController ?? this.textController,
      linkController: linkController ?? this.linkController,
      focusNode: focusNode ?? this.focusNode,
      linkFocusNode: linkFocusNode ?? this.linkFocusNode,
      visible: visible ?? this.visible,
      isExpanded: isExpanded ?? this.isExpanded,
      showLinkInput: showLinkInput ?? this.showLinkInput,
      debouncedText: debouncedText ?? this.debouncedText,
      selectedImages: selectedImages ?? this.selectedImages,
      links: links ?? this.links,
      buttonState: buttonState ?? this.buttonState,
      opacity: opacity ?? this.opacity,
    );
  }
}
