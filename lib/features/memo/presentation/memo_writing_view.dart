import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/input/writing_menu_bar/writing_menu_bar.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_viewmodel.dart';

class WritingView extends StatefulWidget {
  const WritingView({super.key});

  @override
  State<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends State<WritingView> {
  late final WritingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WritingViewModel();
  }

  @override
  void dispose() {
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
            const WritingMenuBar(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
