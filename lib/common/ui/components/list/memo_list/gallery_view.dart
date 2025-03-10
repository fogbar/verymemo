import 'dart:io';

import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';

class GalleryView extends ConsumerWidget {
  final Function(String imageUrl)? onImageTap;

  const GalleryView({
    super.key,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var viewModel = MemoHomeViewModel();
    // final memos = viewModel.extractImages();
    final viewModel = ref.read(memoHomeProvider.notifier);
    final memos = viewModel.memoList;

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
          onTap: () {
            showDialog(
              context: context,
              barrierColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              builder: (context) => ImageDetailView(
                imageUrl: memo.images![index].imageUrl!,
                imageUrls:
                    memo.images!.map((e) => e.imageUrl.toString()).toList(),
                currentIndex: index,
                onClose: () => Navigator.pop(context),
              ),
            );
          },
        );
      },
    );
  }
}

class GalleryItem extends StatelessWidget {
  final MemoModel memo;
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
            image: FileImage(File(memo.images!.first.imageUrl!)),
            fit: BoxFit.cover,
          ),
        ),
        child: memo.images!.length > 1
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
                    '${memo.images!.length}',
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
