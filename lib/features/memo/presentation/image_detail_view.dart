import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/memo/presentation/image_detail_viewmodel.dart';

final currentPageProvider = StateProvider.autoDispose
    .family<int, int>((ref, initialIndex) => initialIndex);

class ImageDetailView extends ConsumerWidget {
  final String imageUrl;
  final List<String> imageUrls;
  final int currentIndex;
  final VoidCallback? onClose;

  const ImageDetailView({
    super.key,
    required this.imageUrl,
    required this.imageUrls,
    required this.currentIndex,
    this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(imageDetailProvider((
      initialIndex: currentIndex,
      imageUrls: imageUrls,
    )));

    final currentPage = ref.watch(currentPageProvider(currentIndex));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
            itemBuilder: (context, index) => GestureDetector(
              onDoubleTapDown: viewModel.handleDoubleTap,
              child: InteractiveViewer(
                transformationController: viewModel.transformationController,
                minScale: 0.5,
                maxScale: 4.0,
                child: _buildImage(imageUrls[index]),
              ),
            ),
          ),
          VariableHeader(
            type: HeaderType.imageviewer,
            onBack: onClose,
            onDelete: viewModel.handleDelete,
            onDownload: viewModel.handleDownload,
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
                          ? colorScheme.primary // 현재 페이지
                          : colorScheme.onPrimary.withOpacity(0.2), // 다른 페이지
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Center(
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
