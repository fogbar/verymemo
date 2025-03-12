import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/image_detail_viewmodel.dart';
import 'dart:io';

final currentPageProvider = StateProvider.autoDispose
    .family<int, int>((ref, initialIndex) => initialIndex);

class ImageDetailView extends ConsumerWidget {
  final String imageUrl;
  final List<String> imageUrls;
  final int currentIndex;
  final VoidCallback onClose;
  final bool isLocalFile;
  final bool showDelete;
  final bool showDownload;
  final VoidCallback? onDelete;
  final VoidCallback? onDownload;

  const ImageDetailView({
    super.key,
    required this.imageUrl,
    required this.imageUrls,
    required this.currentIndex,
    required this.onClose,
    this.isLocalFile = false,
    this.showDelete = true,
    this.showDownload = true,
    this.onDelete,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider(currentIndex));
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = ref.watch(imageDetailProvider((
      initialIndex: currentIndex,
      imageUrls: imageUrls,
    )));

    return GestureDetector(
      onVerticalDragUpdate: (details) =>
          viewModel.handleVerticalDragUpdate(details),
      onVerticalDragEnd: (details) =>
          viewModel.handleVerticalDragEnd(details, context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, viewModel.offset, 0),
        child: Opacity(
          opacity: viewModel.opacity,
          child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: colorScheme.surfaceContainerHighest,
            body: Stack(
              children: [
                PageView.builder(
                  itemCount: imageUrls.length,
                  controller: PageController(initialPage: currentIndex),
                  onPageChanged: (index) {
                    ref.read(currentPageProvider(currentIndex).notifier).state =
                        index;
                  },
                  itemBuilder: (context, index) => InteractiveViewer(
                    child: Center(
                      child: isLocalFile
                          ? Image.file(File(imageUrls[index]))
                          : Image.network(imageUrls[index]),
                    ),
                  ),
                ),
                if (imageUrls.length > 1)
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        imageUrls.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentPage
                                ? colorScheme.primary
                                : colorScheme.onPrimary.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                VariableHeader(
                  type: HeaderType.imageviewer,
                  onBack: onClose,
                  onDelete: showDelete ? onDelete : null,
                  onDownload: showDownload ? onDownload : null,
                  showDelete: showDelete,
                  showDownload: showDownload,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
