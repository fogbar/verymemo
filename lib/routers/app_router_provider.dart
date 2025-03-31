part of 'router.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

class AppRouter {
  final Ref ref;
  AppRouter(this.ref);

  // Helper function to create GoRoute
  GoRoute _buildGoRoute(String path) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => AppRoute.getBuildPage(path, state),
    );
  }

  // Helper function to create StatefulShellBranch
  StatefulShellBranch _buildShellBranch({
    required GlobalKey<NavigatorState> navigatorKey,
    required List<String> paths,
  }) {
    return StatefulShellBranch(
      navigatorKey: navigatorKey,
      routes: paths.map((path) => _buildGoRoute(path)).toList(),
    );
  }

  // StatefulShellRoute 생성 헬퍼
  // / parentNavigatorKey 매개변수의 경우 최상위 화면 컨트롤 하는 부분에서는 필요 없기에
  // / 초기값 null 로 할당
  StatefulShellRoute _buildStatefulShellRoute({
    required GlobalKey<NavigatorState>? parentNavigatorKey,
    required Widget Function(
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell navigationShell,
    ) shellBuilder,
    required List<StatefulShellBranch> branches,
  }) {
    return StatefulShellRoute(
      parentNavigatorKey: parentNavigatorKey,
      builder: shellBuilder,
      navigatorContainerBuilder: (context, navigationShell, children) =>
          children[navigationShell.currentIndex],
      branches: branches,
    );
  }

  late final config = GoRouter(
    initialLocation: AppRoute.home,
    navigatorKey: NavigatorKey.routerKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(permissionNotifierProvider.notifier).stream,
    ),
    routes: [
      // ✅ 인트로 관련 (Shell 구조)
      _buildStatefulShellRoute(
        parentNavigatorKey: null,
        shellBuilder: (context, state, navigationShell) {
          return IntroScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        branches: [
          _buildShellBranch(
            navigatorKey: NavigatorKey.splashBranchKey,
            paths: [AppRoute.splash],
          ),
          _buildShellBranch(
            navigatorKey: NavigatorKey.introBranchKey,
            paths: [AppRoute.intro],
          ),
          _buildShellBranch(
            navigatorKey: NavigatorKey.permissionCheckBranchKey,
            paths: [AppRoute.permissionCheck],
          ),
          _buildShellBranch(
            navigatorKey: NavigatorKey.loginBranchKey,
            paths: [AppRoute.signup],
          ),
          _buildShellBranch(
            navigatorKey: NavigatorKey.profileSettingBranchKey,
            paths: [AppRoute.profileSetting],
          ),
        ],
      ),

      // ✅ 홈 쉘
      _buildStatefulShellRoute(
        parentNavigatorKey: null,
        shellBuilder: (context, state, navigationShell) {
          return HomeScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        branches: [
          // ✅ 메모 홈 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.homeBranchKey,
            paths: [AppRoute.home],
          ),
          // ✅ 소개 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.feedBranchKey,
            paths: [AppRoute.feed],
          ),
        ],
      ),

      // ✅ 디테일 쉘
      _buildStatefulShellRoute(
        parentNavigatorKey: null,
        shellBuilder: (context, state, navigationShell) {
          return DetailScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        branches: [
          // ✅ 수정 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.editBranchKey,
            paths: [AppRoute.edit],
          ),
          // ✅ 삭제 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.deleteBranchKey,
            paths: [AppRoute.delete],
          ),
          // ✅ 설정 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.settingsBranchKey,
            paths: [AppRoute.settings],
          ),
        ],
      ),

      // ✅ 빈 쉘
      _buildStatefulShellRoute(
        parentNavigatorKey: null,
        shellBuilder: (context, state, navigationShell) {
          return EmptyScaffold(
            navigationShell: navigationShell,
            state: state,
          );
        },
        branches: [
          // ✅ 찾기 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.searchBranchKey,
            paths: [AppRoute.search],
          ),
          // ✅ 디테일 화면
          _buildShellBranch(
            navigatorKey: NavigatorKey.detailBranchKey,
            paths: [AppRoute.detail, AppRoute.detailId],
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
