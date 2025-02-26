import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/domain/models/memo_list_model.dart';
import 'package:verymemo/features/memo/presentation/memo_home_viewmodel.dart';

class GalleryView extends ConsumerWidget {
  final Function(String imageUrl)? onImageTap;

  const GalleryView({
    super.key,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = MemoListViewModel();
    final memos = viewModel.extractImages();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // mainAxisSpacing: 8,
        // crossAxisSpacing: 8,
      ),
      itemCount: memos.length,
      itemBuilder: (context, index) {
        final memo = memos[index];
        return GalleryItem(
          memo: memo,
          onTap: () => onImageTap?.call(memo.imageUrls!.first),
        );
      },
    );
  }
}

class GalleryItem extends StatelessWidget {
  final MemoListModel memo;
  final VoidCallback? onTap;

  const GalleryItem({
    super.key,
    required this.memo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(memo.imageUrls!.first),
            fit: BoxFit.cover,
          ),
        ),
        child: memo.imageUrls!.length > 1
            ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin:
                      const EdgeInsets.all(GalleryViewConfig.imageCountPadding),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(GalleryViewConfig.imageCountOpacity),
                    borderRadius: BorderRadius.circular(
                        GalleryViewConfig.imageCountBorderRadius),
                  ),
                  child: Text(
                    '${memo.imageUrls!.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: GalleryViewConfig.imageCountFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

// Config
class GalleryViewConfig {
  static const double imageCountPadding = 8.0;
  static const double imageCountBorderRadius = 8.0;
  static const double imageCountFontSize = 12.0;
  static const double imageCountOpacity = 0.6;
}
