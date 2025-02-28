import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageDetailViewModel extends ChangeNotifier {
  final int initialIndex;
  final List<String> imageUrls;
  late final PageController pageController;
  final TransformationController transformationController = TransformationController();
  
  ImageDetailViewModel({
    required this.initialIndex,
    required this.imageUrls,
  }) {
    pageController = PageController(initialPage: initialIndex);
  }

  void handleDoubleTap(TapDownDetails details) {
    if (transformationController.value != Matrix4.identity()) {
      // 확대된 상태에서 더블탭하면 원래 크기로
      transformationController.value = Matrix4.identity();
    } else {
      // 원래 크기에서 더블탭하면 2배 확대
      final position = details.localPosition;
      transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 1.0, -position.dy * 1.0)
        ..scale(2.0);
    }
  }

  void handleDownload() {
    // 다운로드 로직
  }

  void handleDelete() {
    // 삭제 로직
  }

  @override
  void dispose() {
    pageController.dispose();
    transformationController.dispose();
    super.dispose();
  }
}

final imageDetailProvider = ChangeNotifierProvider.autoDispose.family<ImageDetailViewModel, ({int initialIndex, List<String> imageUrls})>((ref, params) {
  return ImageDetailViewModel(
    initialIndex: params.initialIndex,
    imageUrls: params.imageUrls,
  );
});

final currentPageProvider = StateProvider.autoDispose<int>((ref) => 0); 