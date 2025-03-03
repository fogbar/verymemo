import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/memo/presentation/image_detail_viewmodel.dart';
import 'dart:io';

final currentPageProvider = StateProvider.autoDispose
    .family<int, int>((ref, initialIndex) => initialIndex);

class ImageDetailView extends ConsumerWidget {
  final String imageUrl;
  final List<String> imageUrls;
  final int currentIndex;
  final VoidCallback? onClose;
  final bool isLocalFile;

  const ImageDetailView({
    super.key,
    required this.imageUrl,
    required this.imageUrls,
    required this.currentIndex,
    this.onClose,
    this.isLocalFile = false,
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
            onDelete: viewModel.handleDelete,
            // onDownload: viewModel.handleDownload,
          ),
        ],
      ),
    );
  }
}
