part of 'router.dart';

// ✅ 라우터 이름
abstract class AppRoute {
  static const splash = "/splash";
  static const intro = "/intro";
  static const signup = "/sign-up";
  static const permissionCheck = "/permissionCheck";
  static const profileSetting = "/profileSetting";
  static const home = "/home";
  static const edit = "/edit";
  static const detail = "/detail";
  static const feed = "/feed";
  static const delete = "/delete";
  static const search = "/search";
  static const settings = "/settings";
}

// ✅ Navigator Key
abstract class NavigatorKey {
  static final GlobalKey<NavigatorState> routerKey =
      GlobalKey<NavigatorState>(debugLabel: "routerKey");

  static final GlobalKey<NavigatorState> introShellKey =
      GlobalKey<NavigatorState>(debugLabel: "introShellKey");

  static final GlobalKey<NavigatorState> homeShellKey =
      GlobalKey<NavigatorState>(debugLabel: "homeShellKey");

  static final GlobalKey<NavigatorState> detailShellKey =
      GlobalKey<NavigatorState>(debugLabel: "detailShellKey");

  static final GlobalKey<NavigatorState> emptyShellKey =
      GlobalKey<NavigatorState>(debugLabel: "emptyShellKey");

  static final GlobalKey<NavigatorState> splashBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "splashBranchKey");

  static final GlobalKey<NavigatorState> introBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "introBranchKey");

  static final GlobalKey<NavigatorState> permissionCheckBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "permissionCheckBranchKey");

  static final GlobalKey<NavigatorState> loginBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "loginBranchKey");

  static final GlobalKey<NavigatorState> homeBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "homeBranchKey");

  static final GlobalKey<NavigatorState> editBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "editBranchKey");

  static final GlobalKey<NavigatorState> detailBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "detailBranchKey");

  static final GlobalKey<NavigatorState> feedBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "feedBranchKey");

  static final GlobalKey<NavigatorState> searchBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "searchBranchKey");

  static final GlobalKey<NavigatorState> settingsBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "settingsBranchKey");

  static final GlobalKey<NavigatorState> profileSettingBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "profileSettingBranchKey");

  static final GlobalKey<NavigatorState> deleteBranchKey =
      GlobalKey<NavigatorState>(debugLabel: "deleteBranchKey");
}

// ✅ 공통 Shell 클래스화
abstract class Shell extends StatefulShellRouteData {
  const Shell();

  Widget buildScaffold(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell);

  GlobalKey<NavigatorState> get shellKey;

  @override
  Widget builder(BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) =>
      buildScaffold(context, state, navigationShell);
}

// ✅ 공통 브랜치 클래스화
abstract class Branch extends StatefulShellBranchData {
  final String initialLocation;
  final Widget? selectedIcon;
  final Widget? icon;
  final String label;

  const Branch({
    required this.initialLocation,
    this.selectedIcon,
    this.icon,
    required this.label,
  });

  NavigationDestination get destination => NavigationDestination(
        icon: icon ?? const SizedBox.shrink(),
        selectedIcon: selectedIcon,
        label: label,
      );

  GlobalKey<NavigatorState> get branchKey;
}

// ✅ 공통 라우트 클래스화
abstract class Route extends GoRouteData {
  final Widget child;
  final String? path;
  const Route(this.child, {this.path});

  static String? $vaildatePath(String path) {
    if (path.isNotEmpty) return path;
    return null;
  }

  // // 에러 대화창 표시
  // void showErrorDialog(BuildContext context, String message);

  // 인증 여부 확인
  bool checkAuth(BuildContext context);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (Platform.isIOS) {
      return CupertinoPage(
        key: state.pageKey,
        child: child,
        maintainState: true,
        fullscreenDialog: false,
      );
    }

    return MaterialPage(
      key: state.pageKey,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: child,
      ),
      maintainState: true,
      fullscreenDialog: false,
    );
  }
}
