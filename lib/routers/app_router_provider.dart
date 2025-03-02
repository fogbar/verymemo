part of 'router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  // final interceptor = ref.watch(appRouterInterceptorProvider);
  return AppRouter(ref);
});

class AppRouter {
  // final AppRouterInterceptor interceptor;
  final Ref ref;

  AppRouter(this.ref);
  late final config = GoRouter(
    navigatorKey: NavigatorKey.routerKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    refreshListenable: GoRouterRefreshStream(
        ref.watch(permissionNotifierProvider.notifier).stream),
    redirect: (context, state) async {
      final storageService = ref.watch(storageProvider);
      final isNew = await storageService.get(key: deviceId) != null;
      final permissionState = ref.read(permissionNotifierProvider);
      final allPermissionsGranted = permissionState.allGranted;

      // 🔥 모든 권한이 허용된 경우 → 로그인 페이지로 리다이렉트
      if (allPermissionsGranted) {
        if (!state.matchedLocation.contains(AppRoute.home)) {
          return AppRoute.signup;
        }
      }
      // if (context.mounted) {
      //   // 1. 처음은 아닌데 인증이 필요한 라우트인 경우: 로그인으로 리다이렉트
      //   if (!isNew &&
      //       _findRouteByPath(state.matchedLocation)!.checkAuth(context)) {
      //     return AppRoute.login;
      //   }

      //   // 2. 처음은 아니면서, 인증이 필요없는 라우트인 경우: 홈으로 리다이렉트
      //   if (!isNew &&
      //       !_findRouteByPath(state.matchedLocation)!.checkAuth(context)) {
      //     return AppRoute.home;
      //   }

      //   // 3. 처음인 경우: 인트로로 리다이렉트
      //   if (isNew) {
      //     return AppRoute.intro;
      //   }
      // }
      return null;
    },
    initialLocation: AppRoute.signup,
  );

  static Route? _findRouteByPath(String path) {
    switch (path) {
      case AppRoute.intro:
        return const IntroRoute();
      case AppRoute.permissionCheck:
        return const PermissionCheckRoute();
      case AppRoute.signup:
        return const LoginRoute();
      case AppRoute.profileSetting:
        return const ProfileSettingRoute();
      case AppRoute.home:
        return HomeRoute();
      case AppRoute.edit:
        return const EditRoute();
      case AppRoute.feed:
        return const FeedRoute();
      case AppRoute.delete:
        return const DeleteRoute();
      case AppRoute.search:
        return const SearchRoute();
      case AppRoute.settings:
        return const SettingsRoute();
      default:
        return null;
    }
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
