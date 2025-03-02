import 'package:flutter/material.dart';
import 'package:verymemo/features/memo/presentation/writing_menu_bar/writing_menu_bar.dart';
import 'package:verymemo/features/memo/presentation/memo_writing_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/presentation/providers/writing_provider.dart';
import 'dart:io';
import 'package:verymemo/features/memo/presentation/image_detail_view.dart';

class WritingView extends ConsumerStatefulWidget {
  const WritingView({super.key});

  @override
  ConsumerState<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends ConsumerState<WritingView> {
  late final viewModel = WritingViewModel();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() {
      if (mounted) setState(() {}); // 상태 변화 감지
    });
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
    viewModel.removeListener(() {}); // 리스너 제거
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
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.3), // 메인 컨테이너 배경
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
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            if (viewModel.selectedImages.isNotEmpty)
              Container(
                color: Colors.blue.withOpacity(0.3), // 이미지 리스트뷰 영역
                height: 80,
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.selectedImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          builder: (context) => ImageDetailView(
                            imageUrl: viewModel.selectedImages[index],
                            imageUrls: viewModel.selectedImages,
                            currentIndex: index,
                            onClose: () => Navigator.pop(context),
                            isLocalFile: true,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(viewModel.selectedImages[index]),
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            Expanded(
              child: Container(
                color: Colors.green.withOpacity(0.3), // TextField 영역
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
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.red.withOpacity(0.3), // WritingMenuBar 영역
              child: WritingMenuBar(
                onGalleryTap: viewModel.pickImages,
              ),
            ),
            Container(
              color: Colors.purple.withOpacity(0.3), // 하단 여백 영역
              child: const SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
