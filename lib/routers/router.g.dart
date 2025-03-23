// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $introShell,
      $homeShell,
      $detailShell,
      $emptyShell,
    ];

RouteBase get $introShell => StatefulShellRouteData.$route(
      factory: $IntroShellExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/splash',
              factory: $SplashRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/intro',
              factory: $IntroRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/permissionCheck',
              factory: $PermissionCheckRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/sign-up',
              factory: $LoginRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/profileSetting',
              factory: $ProfileSettingRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $IntroShellExtension on IntroShell {
  static IntroShell _fromState(GoRouterState state) => IntroShell();
}

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $IntroRouteExtension on IntroRoute {
  static IntroRoute _fromState(GoRouterState state) => const IntroRoute();

  String get location => GoRouteData.$location(
        '/intro',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PermissionCheckRouteExtension on PermissionCheckRoute {
  static PermissionCheckRoute _fromState(GoRouterState state) =>
      const PermissionCheckRoute();

  String get location => GoRouteData.$location(
        '/permissionCheck',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileSettingRouteExtension on ProfileSettingRoute {
  static ProfileSettingRoute _fromState(GoRouterState state) =>
      const ProfileSettingRoute();

  String get location => GoRouteData.$location(
        '/profileSetting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShell => StatefulShellRouteData.$route(
      factory: $HomeShellExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/feed',
              factory: $FeedRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeShellExtension on HomeShell {
  static HomeShell _fromState(GoRouterState state) => HomeShell();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FeedRouteExtension on FeedRoute {
  static FeedRoute _fromState(GoRouterState state) => const FeedRoute();

  String get location => GoRouteData.$location(
        '/feed',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $detailShell => StatefulShellRouteData.$route(
      factory: $DetailShellExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/edit',
              factory: $EditRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/detail',
              factory: $DetailEntryRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $DetailRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/delete',
              factory: $DeleteRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/settings',
              factory: $SettingsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $DetailShellExtension on DetailShell {
  static DetailShell _fromState(GoRouterState state) => DetailShell();
}

extension $EditRouteExtension on EditRoute {
  static EditRoute _fromState(GoRouterState state) => const EditRoute();

  String get location => GoRouteData.$location(
        '/edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DetailEntryRouteExtension on DetailEntryRoute {
  static DetailEntryRoute _fromState(GoRouterState state) =>
      const DetailEntryRoute();

  String get location => GoRouteData.$location(
        '/detail',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DetailRouteExtension on DetailRoute {
  static DetailRoute _fromState(GoRouterState state) => DetailRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/detail/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeleteRouteExtension on DeleteRoute {
  static DeleteRoute _fromState(GoRouterState state) => const DeleteRoute();

  String get location => GoRouteData.$location(
        '/delete',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $emptyShell => StatefulShellRouteData.$route(
      factory: $EmptyShellExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/search',
              factory: $SearchRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $EmptyShellExtension on EmptyShell {
  static EmptyShell _fromState(GoRouterState state) => EmptyShell();
}

extension $SearchRouteExtension on SearchRoute {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
