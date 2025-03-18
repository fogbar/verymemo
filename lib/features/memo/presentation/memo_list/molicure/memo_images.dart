import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_home_viewmodel.dart';
import 'dart:io';

//이미지 캐싱 추가함
class MemoImages extends ConsumerWidget {
  final MemoModel memo;

  const MemoImages({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoHomeProvider.notifier);

    return viewModel.isDesktopPlatform
        ? _GridView(memo: memo, viewModel: viewModel)
        : _CarouselView(memo: memo, viewModel: viewModel);
  }
}

class _CarouselView extends StatelessWidget {
  final MemoModel memo;
  final MemoHomeViewModel viewModel;
  static final Map<String, Image> _imageCache = {}; // 메모리 캐시 추가

  const _CarouselView({
    required this.memo,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 72.0;
    const double spacing = 8.0;
    const double horizontalPadding = 16.0;

    final imageUrls = memo.images ?? [];
    debugPrint('이미지 URLs: ${imageUrls.map((e) => e.imageUrl).toList()}');

    return SizedBox(
      height: imageSize,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            const SizedBox(width: horizontalPadding),
            ...List.generate(
              imageUrls.length,
              (index) {
                debugPrint('이미지 URL $index: ${imageUrls[index].imageUrl}');
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == imageUrls.length - 1
                        ? horizontalPadding
                        : spacing,
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        viewModel.showImageDetail(context, memo, index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildCachedImage(
                        imageUrls[index].imageUrl ?? '',
                        imageSize,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCachedImage(String imagePath, double size) {
    if (!_imageCache.containsKey(imagePath)) {
      _imageCache[imagePath] = Image.file(
        File(imagePath),
        width: size,
        height: size,
        fit: BoxFit.cover,
        cacheWidth: (size * 2).toInt(), // 디바이스 픽셀 비율 고려
        gaplessPlayback: true, // 깜빡임 방지
      );
    }
    return _imageCache[imagePath]!;
  }
}

class _GridView extends StatelessWidget {
  final MemoModel memo;
  final MemoHomeViewModel viewModel;

  const _GridView({
    required this.memo,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrls = memo.images?.map((e) => e.imageUrl.toString()).toList();
    final displayImages = viewModel.getDisplayImages(imageUrls);

    return Row(
      children: displayImages.asMap().entries.map((entry) {
        final index = entry.key;
        final url = entry.value;
        final isLast = index == viewModel.getDisplayCount(imageUrls) - 1;

        Widget imageContent = GestureDetector(
          onTap: () => viewModel.showImageDetail(context, memo, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: viewModel.shouldShowRemainingCount(imageUrls, index)
                ? _RemainingCountOverlay(
                    memo: memo, url: url, viewModel: viewModel)
                : Image.file(
                    File(url),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('이미지 로드 에러: $error');
                      return Container(
                        width: 104,
                        height: 104,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
          ),
        );

        Widget sizedContent = SizedBox(
          width: 104,
          height: 104,
          child: imageContent,
        );

        Widget paddedContent = Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : 8.0),
          child: viewModel.isUseFixedSize(imageUrls)
              ? sizedContent
              : AspectRatio(
                  aspectRatio: 1,
                  child: imageContent,
                ),
        );

        return viewModel.isUseFixedSize(imageUrls)
            ? paddedContent
            : Expanded(child: paddedContent);
      }).toList(),
    );
  }
}

class _RemainingCountOverlay extends StatelessWidget {
  final MemoModel memo;
  final String url;
  final MemoHomeViewModel viewModel;

  const _RemainingCountOverlay({
    required this.memo,
    required this.url,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          File(url),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('이미지 로드 에러: $error');
            return Container(
              width: 104,
              height: 104,
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            );
          },
        ),
        Container(
          color: Theme.of(context).colorScheme.surfaceDim,
          child: Center(
            child: Text(
              '+${viewModel.getRemainingCount(memo.images?.map((e) => e.imageUrl.toString()).toList())}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
