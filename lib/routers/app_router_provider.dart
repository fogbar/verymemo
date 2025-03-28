part of 'router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

class AppRouter {
  final Ref ref;
  AppRouter(this.ref);

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final config = GoRouter(
    // initialLocation: AppRoute.splash,
    initialLocation: AppRoute.signup,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(permissionNotifierProvider.notifier).stream,
    ),
    routes: [
      // ✅ 인트로 관련 (Shell 구조)
      StatefulShellRoute(
        parentNavigatorKey: _rootNavigatorKey, // ✅ 루트 스택에 포함되도록
        pageBuilder: (context, state, navigationShell) => CupertinoPage(
          key: state.pageKey,
          child: IntroScaffold(
            navigationShell: navigationShell,
            state: state,
          ),
        ),
        navigatorContainerBuilder: (context, navigationShell, children) =>
            children[navigationShell.currentIndex],
        branches: [
          StatefulShellBranch(
            navigatorKey: NavigatorKey.splashBranchKey,
            routes: [
              GoRoute(
                path: AppRoute.splash,
                pageBuilder: (context, state) => CupertinoPage(
                  key: state.pageKey,
                  child: const SplashView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.introBranchKey,
            routes: [
              GoRoute(
                path: AppRoute.intro,
                pageBuilder: (context, state) => CupertinoPage(
                  key: state.pageKey,
                  child: const PermissionView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.permissionCheckBranchKey,
            routes: [
              GoRoute(
                path: AppRoute.permissionCheck,
                pageBuilder: (context, state) => CupertinoPage(
                  key: state.pageKey,
                  child: const IntroView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.loginBranchKey,
            routes: [
              GoRoute(
                path: AppRoute.signup,
                pageBuilder: (context, state) => CupertinoPage(
                  key: state.pageKey,
                  child: const AuthView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.profileSettingBranchKey,
            routes: [
              GoRoute(
                path: AppRoute.profileSetting,
                pageBuilder: (context, state) => CupertinoPage(
                  key: state.pageKey,
                  child: const ProfileSettingView(),
                ),
              ),
            ],
          ),
        ],
      ),

      // ✅ 앱 메인 라우트들 (rootNavigator로 push)
      GoRoute(
        path: AppRoute.home,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const MemoHomeView(),
        ),
      ),
      GoRoute(
        path: AppRoute.feed,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const FeedView(),
        ),
      ),
      GoRoute(
        path: AppRoute.search,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const SearchView(),
        ),
      ),
      GoRoute(
        path: AppRoute.edit,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const MemoEditView(),
        ),
      ),
      GoRoute(
        path: AppRoute.delete,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const MemoDeleteView(),
        ),
      ),
      GoRoute(
        path: '/detail/:id',
        parentNavigatorKey: _rootNavigatorKey, // ✅ 루트에서 push됨 → 제스처 OK
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CupertinoPage(
            key: state.pageKey,
            child: MemoDetailView(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoute.settings,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: const SettingsView(),
        ),
      ),
    ],
  );
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
