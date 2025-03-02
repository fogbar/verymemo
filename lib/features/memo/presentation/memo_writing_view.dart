import 'package:flutter/material.dart';
import 'package:verymemo/features/memo/presentation/writing_menu_bar/writing_menu_bar.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/presentation/providers/writing_provider.dart';

class WritingView extends ConsumerStatefulWidget {
  const WritingView({super.key});

  @override
  ConsumerState<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends ConsumerState<WritingView> {
  late final WritingViewModel viewModel;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    viewModel = WritingViewModel();
    viewModel.textController.addListener(_onTextChanged);

    // 빌드 완료 후 포커스 요청
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _onTextChanged() {
    ref
        .read(writingMenuStateProvider.notifier)
        .setUploadButtonState(viewModel.textController.text);
  }

  @override
  void dispose() {
    viewModel.textController.removeListener(_onTextChanged);
    _focusNode.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, -6),
              spreadRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: viewModel.textController,
                  focusNode: _focusNode,
                  autofocus: true,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "내용을 입력하세요...",
                    border: InputBorder.none,
                    filled: false,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            WritingMenuBar(
              onGalleryTap: viewModel.pickImages,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
