// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/routers/router.dart';

final navigationServiceProvider =
    Provider<NavigationService>((ref) => NavigationService());

/// 동준 추천.
/// 최대한 pop 은 context 에서 한다.
/// 최상위를 덮는 replace, pushReplacement 등과 모든 네비게이션 스택을 삭제하고 처음부터 다시 쌓는 것은 다름. 이 부분에 대한 이해도가 있으면 좋음.
/// ㄴ 향후 애니메이션 다룰때 훨씬 쉬움.

class NavigationService {
  /// 무작정 go 를 쓰는 것이 아니라
  /// aos, ios 에 맞추어 적용하는 것 필요.
  /// go 애니메이션은 각 os 별 ux 에 적합하지 않음.
  /// push, pop, modal, pushReplacement 등을 사용하는거 올바름.
  /// 향후 pushAndRemoveUntil 등을 구현해야 할수도 있음.
  // void go(String path, {Object? arguments}) {
  //   debugPrint("NavigationService go call");
  //   debugPrint("Current context: ${NavigatorKey.routerKey.currentContext}");
  //   debugPrint("Path: $path");

  //   if (NavigatorKey.routerKey.currentContext != null) {
  //     debugPrint(
  //         "NavigationService NavigatorKey.routerKey.currentContext is not null");

  //     GoRouter.of(NavigatorKey.routerKey.currentContext!).go(path);
  //   }
  // }

  void push(String path, {Map<String, dynamic>? params}) {
    debugPrint("NavigationService push call");
    debugPrint("Current context: ${NavigatorKey.routerKey.currentContext}");
    debugPrint("Path: $path");

    if (NavigatorKey.routerKey.currentContext != null) {
      print("값 존재");
      GoRouter.of(NavigatorKey.routerKey.currentContext!).push(path);
    }
  }

  /// push 애니메이션과 함께 최상위 뷰가 덮어 씌어지는 것
  void pushReplacement(String path, {Map<String, dynamic>? params}) {
    if (NavigatorKey.routerKey.currentContext != null) {
      GoRouter.of(NavigatorKey.routerKey.currentContext!).pushReplacement(path);
    }
  }

  /// push 애니메이션 없이 최상위 뷰가 덮어 씌어짐.
  // void replace(String path, {Map<String, dynamic>? params}) {
  //   if (NavigatorKey.routerKey.currentContext != null) {
  //     GoRouter.of(NavigatorKey.routerKey.currentContext!).replace(path);
  //   }
  // }

  /// go router 에는 pushAndRemoveUntil 를 지원하지 않아서 직접 구현
  /// 로그아웃, 회원탈퇴 시에는 반드시 해당 함수로 회원가입 뷰로 넘기기.
  /// ㄴ 기존 네비게이션 스택을 모두 지우지 않으면 뒤로 가기 이슈가 생기기 때문.
  /// 이 부분은 아직 이슈가 있음. 일단 여기까지 만족하고 다음 거로 넘어가고자 함.
  void pushAndRemoveUntil(String path) {
    final goRouter = NavigatorKey.routerKey.currentContext!;

    while (goRouter.canPop()) {
      goRouter.pop();
    }
    goRouter.replace(path);
  }

  void pop([dynamic result]) {
    if (NavigatorKey.routerKey.currentContext != null) {
      GoRouter.of(NavigatorKey.routerKey.currentContext!).pop();
    }
  }
}
