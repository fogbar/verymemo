part of 'router.dart';

// ✅ 라우터 이름
abstract class AppRoute {
  static const intro = "/intro";
  static const permissionCheck = "/permissionCheck";
  static const login = "/login";

  static const home = "/home";
  static const edit = "/edit";
  static const feed = "/feed";
  static const delete = "/delete";
  static const search = "/search";
  static const settings = "/settings";

  static const profileSetting = "/profileSetting";
  static const String imageDetail = '/image-detail';
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
  // Widget build(BuildContext context, GoRouterState state) => child;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 뒤로가기 확인
        final isPopping = secondaryAnimation.status == AnimationStatus.forward;

        if (isPopping) {
          // 뒤로가기 애니메이션
          const begin = Offset.zero;
          const end = Offset(-1.0, 0.0);
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        } else {
          // 앞으로 가기 애니메이션
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }
      },
    );
  }
}
