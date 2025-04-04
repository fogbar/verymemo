import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/barrel/memo_writing.dart';
import 'dart:io';
import 'package:verymemo/features/memo/presentation/views/image_detail_view.dart';

class MemoWritingView extends ConsumerWidget {
  const MemoWritingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoWritingViewModelProvider);
    final viewModel = ref.read(memoWritingViewModelProvider.notifier);
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.5;
    final minHeight = screenHeight * 0.05;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) => viewModel.onWillPop(),
      child: AnimatedOpacity(
        opacity: state.opacity,
        duration: const Duration(milliseconds: 200),
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
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
            constraints: BoxConstraints(
              minHeight: minHeight,
              maxHeight: maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   width: 32,
                //   height: 4,
                //   margin: const EdgeInsets.only(top: 8, bottom: 8),
                //   decoration: BoxDecoration(
                //     color: Theme.of(context)
                //         .colorScheme
                //         .onSurfaceVariant
                //         .withOpacity(0.4),
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                // ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.showLinkInput)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: state.showLinkInput ? 40 : 0,
                            margin: const EdgeInsets.only(top: 24),
                            child: SingleChildScrollView(
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant
                                      .withOpacity(0.5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: state.linkController,
                                        focusNode: state.linkFocusNode,
                                        decoration: InputDecoration(
                                          hintText: "https://",
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              width: 2.0,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: state.linkController.text
                                              .trim()
                                              .isEmpty
                                          ? null
                                          : () => viewModel.addLink(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.check,
                                          color: state.linkController.text
                                                  .trim()
                                                  .isEmpty
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.38)
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (state.links.isNotEmpty)
                          Visibility(
                            visible: state.links.isNotEmpty,
                            maintainState: true,
                            maintainAnimation: true,
                            maintainSize: false,
                            child: LinkPreview(
                              links: state.links
                                  .map((url) => LinkModel(
                                        linkUrl: url.linkUrl,
                                        metaTitle: url.metaTitle,
                                        thumbnail: url.thumbnail,
                                        metaDescription: url.metaDescription,
                                      ))
                                  .toList(),
                              onDeleteTap: (index) =>
                                  viewModel.removeLink(index),
                            ),
                          ),
                        if (state.selectedImages.isNotEmpty)
                          Container(
                            height: 80,
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 16.0,
                            ),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.selectedImages.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
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
                                            imageUrl:
                                                state.selectedImages[index],
                                            imageUrls: state.selectedImages,
                                            currentIndex: index,
                                            onClose: () =>
                                                Navigator.pop(context),
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: minHeight * 0.05,
                            ),
                            child: TextField(
                              controller: state.textController,
                              focusNode: state.focusNode,
                              autofocus: true,
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "어디서든 빠르게 작성하세요",
                                border: InputBorder.none,
                                filled: false,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                              ),
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
                  buttonState: state.buttonState,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
