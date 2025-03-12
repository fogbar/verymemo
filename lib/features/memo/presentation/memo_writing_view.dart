import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'dart:io';
import 'package:verymemo/features/memo/presentation/image_detail_view.dart';

class MemoWritingView extends ConsumerWidget {
  const MemoWritingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoWritingViewModelProvider);
    final viewModel = ref.read(memoWritingViewModelProvider.notifier);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) => viewModel.onWillPop(),
      child: AnimatedOpacity(
        opacity: state.opacity,
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
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [
                if (state.selectedImages.isNotEmpty)
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.selectedImages.length,
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
                                    imageUrl: state.selectedImages[index],
                                    imageUrls: state.selectedImages,
                                    currentIndex: index,
                                    onClose: () => Navigator.pop(context),
                                    isLocalFile: true,
                                    showDelete: true,
                                    showDownload: false,
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(state.selectedImages[index]),
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
                                  viewModel.removeImage(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
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
                            controller: state.textController,
                            focusNode: state.focusNode,
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
                  onGalleryTap: () => viewModel.pickImages(context),
                  onLinkTap: () => viewModel.setLinks(context),
                  onUploadTap: () async {
                    await viewModel.onUploadTab(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
