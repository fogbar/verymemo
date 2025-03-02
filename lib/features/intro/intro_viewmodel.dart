import 'package:verymemo/common/barrel/model_common.dart';

class IntroViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<IntroContent> contents = [
    IntroContent(
      title: '밑으로 끌어당겨\n빠른 메모 쓰기',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: 'PC와 모바일\n언제 어디서나 가볍게 쓰기',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: '링크도 이미지도\n한눈에 보기 쉽게',
      imagePath: 'assets/images/test_image.png',
    ),
    IntroContent(
      title: '공유하고 저장하고\n편리한 메모 관리',
      imagePath: 'assets/images/test_image.png',
    ),
  ];

  IntroViewModel() {
    // 초기화 시 페이지 컨트롤러 리스너 추가
    pageController.addListener(() {
      if (pageController.page?.round() != currentPage) {
        onPageChanged(pageController.page?.round() ?? 0);
      }
    });
  }

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  void onStartButtonPressed() {
    // 다음 화면으로 이동하는 로직 구현
  }

  @override
  void dispose() {
    pageController.removeListener(() {}); // 리스너 제거
    pageController.dispose();
    super.dispose();
  }
}

class IntroContent {
  final String title;
  final String? subtitle;
  final String imagePath;

  IntroContent({
    required this.title,
    this.subtitle,
    required this.imagePath,
  });
}

final introProvider = ChangeNotifierProvider<IntroViewModel>((ref) {
  return IntroViewModel();
});
