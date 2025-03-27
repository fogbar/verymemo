part of 'router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

class AppRouter {
  final Ref ref;

  AppRouter(this.ref);
  late final config = GoRouter(
    initialLocation: AppRoute.splash,
    navigatorKey: NavigatorKey.routerKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
        ref.watch(permissionNotifierProvider.notifier).stream),
    routes: [
      // ✅ 인트로 쉘
      StatefulShellRoute(
        // parentNavigatorKey: NavigatorKey.introShellKey,
        builder: (context, state, navigationShell) {
          return IntroScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        navigatorContainerBuilder: (context, navigationShell, children) =>
            children[navigationShell.currentIndex],
        branches: [
          StatefulShellBranch(
            navigatorKey: NavigatorKey.splashBranchKey,
            routes: [
              // ✅ 스플래시 화면
              GoRoute(
                path: AppRoute.splash,
                builder: (context, state) => const SplashView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.introBranchKey,
            routes: [
              // ✅ 소개 화면
              GoRoute(
                path: AppRoute.intro,
                builder: (context, state) => const PermissionView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.permissionCheckBranchKey,
            routes: [
              // ✅ 권한 확인 화면
              GoRoute(
                path: AppRoute.permissionCheck,
                builder: (context, state) => const IntroView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.loginBranchKey,
            routes: [
              // ✅ 로그인 화면
              GoRoute(
                path: AppRoute.signup,
                builder: (context, state) => const AuthView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.profileSettingBranchKey,
            routes: [
              // ✅ 프로필 설정 화면
              GoRoute(
                path: AppRoute.profileSetting,
                builder: (context, state) => const ProfileSettingView(),
              ),
            ],
          ),
        ],
      ),
      // ✅ 홈 쉘
      StatefulShellRoute(
        // parentNavigatorKey: NavigatorKey.homeShellKey,
        builder: (context, state, navigationShell) {
          return HomeScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        navigatorContainerBuilder: (context, navigationShell, children) =>
            children[navigationShell.currentIndex],
        branches: [
          StatefulShellBranch(
            navigatorKey: NavigatorKey.homeBranchKey,
            routes: [
              // ✅ 메모 홈 화면
              GoRoute(
                path: AppRoute.home,
                builder: (context, state) => const MemoHomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.feedBranchKey,
            routes: [
              // ✅ 소개 화면
              GoRoute(
                path: AppRoute.feed,
                builder: (context, state) => const FeedView(),
              ),
            ],
          ),
        ],
      ),
      // ✅ 디테일 쉘
      StatefulShellRoute(
        // parentNavigatorKey: NavigatorKey.detailShellKey,
        builder: (context, state, navigationShell) {
          return DetailScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        navigatorContainerBuilder: (context, navigationShell, children) =>
            children[navigationShell.currentIndex],
        branches: [
          StatefulShellBranch(
            navigatorKey: NavigatorKey.editBranchKey,
            routes: [
              // ✅ 수정 화면
              GoRoute(
                path: AppRoute.edit,
                builder: (context, state) => const MemoEditView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.deleteBranchKey,
            routes: [
              // ✅ 삭제 화면
              GoRoute(
                path: AppRoute.delete,
                builder: (context, state) => const MemoDeleteView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.settingsBranchKey,
            routes: [
              // ✅ 설정 화면
              GoRoute(
                path: AppRoute.settings,
                builder: (context, state) => const SettingsView(),
              ),
            ],
          ),
        ],
      ),
      // ✅ 빈 쉘
      StatefulShellRoute(
        // parentNavigatorKey: NavigatorKey.emptyShellKey,
        builder: (context, state, navigationShell) {
          return EmptyScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        navigatorContainerBuilder: (context, navigationShell, children) =>
            children[navigationShell.currentIndex],
        branches: [
          StatefulShellBranch(
            navigatorKey: NavigatorKey.searchBranchKey,
            routes: [
              // ✅ 찾기 화면
              GoRoute(
                path: AppRoute.search,
                builder: (context, state) => const SearchView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: NavigatorKey.detailBranchKey,
            routes: [
              // ✅ 디테일 화면
              GoRoute(
                path: AppRoute.detail,
                builder: (context, state) => const SizedBox.shrink(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return MemoDetailView(id: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
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
