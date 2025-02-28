// import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/routers/router.dart';

final navigationServiceProvider =
    Provider<NavigationService>((ref) => NavigationService());

class NavigationService {
  void go(String path, {Object? arguments}) {
    if (NavigatorKey.routerKey.currentContext != null) {
      GoRouter.of(NavigatorKey.routerKey.currentContext!).go(path);
    }
  }

  void push(String path, {Map<String, dynamic>? params}) {
    if (NavigatorKey.routerKey.currentContext != null) {
      GoRouter.of(NavigatorKey.routerKey.currentContext!).push(path);
    }
  }

  void pop([dynamic result]) {
    if (NavigatorKey.routerKey.currentContext != null) {
      GoRouter.of(NavigatorKey.routerKey.currentContext!).pop();
    }
  }
}
