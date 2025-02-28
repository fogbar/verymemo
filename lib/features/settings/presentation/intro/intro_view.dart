import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:verymemo/common/ui/components/button/round_btn.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/common/config/config_box_style.dart';
import 'package:verymemo/features/settings/presentation/intro/intro_viewmodel.dart';

class IntroView extends ConsumerWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(introProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Column(
          children: [
            const Spacer(),
            // 이미지 슬라이더만 PageView로 감싸기
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: viewModel.pageController,
                onPageChanged: viewModel.onPageChanged,
                itemCount: viewModel.contents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38),
                    child: Center(
                      child: Image.asset(
                        'assets/images/test_image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        // 하단 컨텐츠 (고정)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              viewModel.pageController.position.jumpTo(
                  viewModel.pageController.position.pixels - details.delta.dx);
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // 매우 연한 그림자
                    blurRadius: 20, // 그림자를 넓게 퍼뜨림
                    offset: const Offset(0, -4), // 위쪽으로 그림자 방향 설정
                    spreadRadius: 2, // 그림자 확산 정도
                  ),
                ],
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 페이지 인디케이터
                  SmoothPageIndicator(
                    controller: viewModel.pageController,
                    count: viewModel.contents.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      activeDotColor: colorScheme.primary,
                      dotColor: colorScheme.onSurface.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 타이틀과 서브타이틀
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    child: Column(
                      key: ValueKey(viewModel.currentPage),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.contents[viewModel.currentPage].title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          viewModel.contents[viewModel.currentPage].subtitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 시작하기 버튼
                  RoundBtn(
                    text: "기록을 가치 있게",
                    onPressed: () {
                      // 다음 화면으로 이동
                    },
                    size: BoxSize.large,
                    state: ButtonState.secondary,
                    isExpanded: true,
                  ),
                  // 하단 여백
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
