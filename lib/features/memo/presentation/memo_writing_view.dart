import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
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
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() {
      if (mounted) setState(() {});
    });
    viewModel.textController.addListener(_onTextChanged);

    // 빌드 완료 후 포커스 요청 및 페이드 인
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _visible = true);
      _focusNode.requestFocus();
    });
  }

  void _onTextChanged() {
    ref
        .read(writingMenuStateProvider.notifier)
        .setUploadButtonState(viewModel.textController.text);
  }

  Future<bool> _onWillPop() async {
    setState(() => _visible = false);
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, -6),
                  spreadRadius: 8,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                if (viewModel.selectedImages.isNotEmpty)
                  SizedBox(
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
                        return Stack(
                          children: [
                            GestureDetector(
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
                                    showDelete: false,
                                    showDownload: false,
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
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    viewModel.selectedImages.removeAt(index);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 12,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
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
                      ],
                    ),
                  ),
                ),
                WritingMenuBar(
                  onGalleryTap: viewModel.pickImages,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
