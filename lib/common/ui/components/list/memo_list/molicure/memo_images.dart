import 'package:flutter/material.dart';
import 'package:verymemo/features/memo/domain/models/memo_list_model.dart';
import 'package:verymemo/features/memo/presentation/memo_home_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//이미지 캐싱 추가함
class MemoImages extends ConsumerWidget {
  final MemoListModel memo;

  const MemoImages({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoListProvider);

    return viewModel.isDesktopPlatform
        ? _GridView(memo: memo, viewModel: viewModel)
        : _CarouselView(memo: memo, viewModel: viewModel);
  }
}

class _CarouselView extends StatelessWidget {
  final MemoListModel memo;
  final MemoListViewModel viewModel;

  const _CarouselView({
    required this.memo,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 72.0;
    const double spacing = 8.0;
    const double horizontalPadding = 16.0;

    final imageUrls = memo.imageUrls ?? [];

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
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index == imageUrls.length - 1
                      ? horizontalPadding
                      : spacing,
                ),
                child: GestureDetector(
                  onTap: () => viewModel.showImageDetail(context, memo, index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrls[index],
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                      cacheWidth: 300,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  final MemoListModel memo;
  final MemoListViewModel viewModel;

  const _GridView({
    required this.memo,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrls = memo.imageUrls ?? [];
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
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                    cacheWidth: 300,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: child,
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
  final MemoListModel memo;
  final String url;
  final MemoListViewModel viewModel;

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
        Image.network(
          url,
          fit: BoxFit.cover,
          cacheWidth: 300,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            );
          },
        ),
        Container(
          color: Theme.of(context).colorScheme.surfaceDim,
          child: Center(
            child: Text(
              '+${viewModel.getRemainingCount(memo.imageUrls)}',
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
