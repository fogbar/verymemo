import 'dart:io';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';

class GalleryView extends ConsumerWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoState = ref.watch(memoProvider);
    final viewModel = ref.read(memoHomeProvider.notifier);

    return memoState.when(
      initial: () => const Center(child: Text("이미지가 없습니다.")),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => Center(child: Text(error)),
      successed: (memos) {
        final imagesWithMemos = memos
            .where((memo) => memo.images != null && memo.images!.isNotEmpty)
            .toList();

        if (imagesWithMemos.isEmpty) {
          return const Center(child: Text("이미지가 없습니다."));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemCount: imagesWithMemos.length,
          itemBuilder: (context, index) {
            final memo = imagesWithMemos[index];

            return GestureDetector(
              onTap: () => viewModel.showImageDetail(context, memo, 0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  memo.isLocalMemo
                      ? Image.file(
                          File(memo.images!.first.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          memo.images!.first.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                  if (memo.images!.length > 1)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${memo.images!.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
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
