import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<IntroContent> contents = [
    IntroContent(
      title: '밑으로 끌어당겨',
      subtitle: '빠른 메모 쓰기',
    ),
    IntroContent(
      title: 'PC와 모바일',
      subtitle: '언제 어디서나 가볍게 쓰기',
    ),
    IntroContent(
      title: '링크도 이미지도',
      subtitle: '한눈에 보기 쉽게',
    ),
    IntroContent(
      title: '공유하고 저장하고',
      subtitle: '편리한 메모 관리',
    ),
  ];

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class IntroContent {
  final String title;
  final String subtitle;

  IntroContent({
    required this.title,
    required this.subtitle,
  });
}

final introProvider = ChangeNotifierProvider((ref) => IntroViewModel());
