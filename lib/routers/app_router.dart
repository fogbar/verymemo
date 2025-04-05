// part of 'router.dart';

// // @TypedStatefulShellRoute<IntroShell>(
// //   branches: [
// //     TypedStatefulShellBranch<SplashBranch>(
// //       routes: [
// //         TypedGoRoute<SplashRoute>(path: AppRoute.splash),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<IntroBranch>(
// //       routes: [
// //         TypedGoRoute<IntroRoute>(path: AppRoute.intro),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<PermissionCheckBranch>(
// //       routes: [
// //         TypedGoRoute<PermissionCheckRoute>(path: AppRoute.permissionCheck),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<LoginBranch>(
// //       routes: [
// //         TypedGoRoute<LoginRoute>(path: AppRoute.signup),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<ProfileSettingBranch>(
// //       routes: [
// //         TypedGoRoute<ProfileSettingRoute>(path: AppRoute.profileSetting),
// //       ],
// //     ),
// //   ],
// // )
// // class IntroShell extends Shell {
// //   @override
// //   GlobalKey<NavigatorState> get shellKey => NavigatorKey.introShellKey;

// //   @override
// //   Widget buildScaffold(
// //     BuildContext context,
// //     GoRouterState state,
// //     StatefulNavigationShell navigationShell,
// //   ) =>
// //       IntroScaffold(
// //         navigationShell: navigationShell,
// //         state: state,
// //       );
// // }

// // @TypedStatefulShellRoute<HomeShell>(
// //   branches: [
// //     TypedStatefulShellBranch<HomeBranch>(
// //       routes: [
// //         TypedGoRoute<HomeRoute>(path: AppRoute.home),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<FeedBranch>(
// //       routes: [
// //         TypedGoRoute<FeedRoute>(path: AppRoute.feed),
// //       ],
// //     ),
// //   ],
// // )
// // class HomeShell extends Shell {
// //   @override
// //   GlobalKey<NavigatorState> get shellKey => NavigatorKey.homeShellKey;

// //   @override
// //   Widget buildScaffold(
// //     BuildContext context,
// //     GoRouterState state,
// //     StatefulNavigationShell navigationShell,
// //   ) =>
// //       HomeScaffold(
// //         navigationShell: navigationShell,
// //         state: state,
// //       );
// // }

// // @TypedStatefulShellRoute<DetailShell>(
// //   branches: [
// //     TypedStatefulShellBranch<EditBranch>(
// //       routes: [
// //         TypedGoRoute<EditRoute>(path: AppRoute.edit),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<DeleteBranch>(
// //       routes: [
// //         TypedGoRoute<DeleteRoute>(path: AppRoute.delete),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<SettingsBranch>(
// //       routes: [
// //         TypedGoRoute<SettingsRoute>(path: AppRoute.settings),
// //       ],
// //     ),
// //   ],
// // )
// // class DetailShell extends Shell {
// //   @override
// //   GlobalKey<NavigatorState> get shellKey => NavigatorKey.detailShellKey;
// //   @override
// //   Widget buildScaffold(
// //     BuildContext context,
// //     GoRouterState state,
// //     StatefulNavigationShell navigationShell,
// //   ) =>
// //       DetailScaffold(
// //         navigationShell: navigationShell,
// //         state: state,
// //       );
// // }

// // @TypedStatefulShellRoute<EmptyShell>(
// //   branches: [
// //     TypedStatefulShellBranch<SearchBranch>(
// //       routes: [
// //         TypedGoRoute<SearchRoute>(path: AppRoute.search),
// //       ],
// //     ),
// //     TypedStatefulShellBranch<DetailBranch>(
// //       routes: [
// //         TypedGoRoute<DetailEntryRoute>(
// //           path: AppRoute.detail,
// //           routes: [
// //             TypedGoRoute<DetailRoute>(path: ':id'), // ✅ 이제 이게 동작함
// //           ],
// //         ),
// //       ],
// //     ),
// //   ],
// // )
// // class EmptyShell extends Shell {
// //   @override
// //   GlobalKey<NavigatorState> get shellKey => NavigatorKey.emptyShellKey;
// //   @override
// //   Widget buildScaffold(BuildContext context, GoRouterState state,
// //           StatefulNavigationShell navigationShell) =>
// //       EmptyScaffold(navigationShell: navigationShell, state: state);
// // }

// ////////////////////////////////////////////////////////////
// // ✅ Splash 브랜치
// // class SplashBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.splashBranchKey;

// //   SplashBranch()
// //       : super(
// //           initialLocation: AppRoute.splash,
// //           label: "스플래시",
// //         );
// // }

// // // ✅ Intro 브랜치
// // class IntroBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.introBranchKey;

// //   IntroBranch()
// //       : super(
// //           initialLocation: AppRoute.intro,
// //           label: "인트로",
// //         );
// // }

// // // ✅ PermissionCheck 브랜치
// // class PermissionCheckBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey =>
// //       NavigatorKey.permissionCheckBranchKey;

// //   PermissionCheckBranch()
// //       : super(
// //           initialLocation: AppRoute.permissionCheck,
// //           label: "권한 확인",
// //         );
// // }

// // // ✅ Login 브랜치
// // class LoginBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.loginBranchKey;

// //   LoginBranch()
// //       : super(
// //           initialLocation: AppRoute.signup,
// //           label: "로그인",
// //         );
// // }

// // // ✅ 프로필세팅 브랜치
// // class ProfileSettingBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey =>
// //       NavigatorKey.profileSettingBranchKey;

// //   ProfileSettingBranch()
// //       : super(
// //           initialLocation: AppRoute.profileSetting,
// //           label: "프로필 설정",
// //         );
// // }

// // // ✅ 홈 브랜치
// // class HomeBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.homeBranchKey;

// //   HomeBranch()
// //       : super(
// //           initialLocation: AppRoute.home,
// //           // selectedIcon: ImageUtil.showImage(
// //           //   "assets/icons/memo.svg",
// //           // ),
// //           // icon: ImageUtil.showImage("assets/icons/memo_unselecetd.svg"),
// //           label: "홈",
// //         );
// // }

// // // ✅ Edit 브랜치
// // class EditBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.editBranchKey;

// //   EditBranch()
// //       : super(
// //           initialLocation: AppRoute.edit,
// //           label: "수정",
// //         );
// // }

// // // ✅ Detail 브랜치
// // class DetailBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.detailBranchKey;

// //   DetailBranch()
// //       : super(
// //           initialLocation: AppRoute.detail,
// //           label: "상세",
// //         );
// // }

// // // ✅ Delete 브랜치
// // class DeleteBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.deleteBranchKey;

// //   DeleteBranch()
// //       : super(
// //           initialLocation: AppRoute.delete,
// //           // selectedIcon: ImageUtil.showImage(
// //           //   "assets/icons/delete.svg",
// //           //   color: Colors.white,
// //           // ),
// //           // icon: ImageUtil.showImage(
// //           //   "assets/icons/delete.svg",
// //           // ),
// //           label: "삭제",
// //         );
// // }

// // // ✅ Feed 브랜치
// // class FeedBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.feedBranchKey;

// //   FeedBranch()
// //       : super(
// //           initialLocation: AppRoute.feed,
// //           // selectedIcon: ImageUtil.showImage("assets/icons/feed.svg",
// //           //     color: Color(0xffFF6D75)),
// //           // icon: ImageUtil.showImage("assets/icons/feed.svg"),
// //           label: "피드",
// //         );
// // }

// // // ✅ Search 브랜치
// // class SearchBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.searchBranchKey;

// //   SearchBranch()
// //       : super(
// //           initialLocation: AppRoute.search,
// //           // selectedIcon: ImageUtil.showImage(
// //           //   "assets/icons/search.svg",
// //           //   color: Colors.white,
// //           // ),
// //           // icon: ImageUtil.showImage(
// //           //   "assets/icons/search_unselected.svg",
// //           // ),
// //           label: "검색",
// //         );
// // }

// // // ✅ Settings 브랜치
// // class SettingsBranch extends Branch {
// //   @override
// //   GlobalKey<NavigatorState> get branchKey => NavigatorKey.settingsBranchKey;

// //   SettingsBranch()
// //       : super(
// //           initialLocation: AppRoute.settings,
// //           // selectedIcon: ImageUtil.showImage(
// //           //   "assets/icons/more.svg",
// //           //   color: Colors.white,
// //           // ),
// //           // icon: ImageUtil.showImage(
// //           //   "assets/icons/more.svg",
// //           // ),
// //           label: "설정",
// //         );
// // }

// ////////////////////////////////////////////////////////////
// // ✅ 스플래시 라우터
// @TypedGoRoute<SplashRoute>(path: AppRoute.splash)
// class SplashRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => false;

//   const SplashRoute() : super(const SplashView());
// }

// // ✅ 인트로 라우터
// @TypedGoRoute<IntroRoute>(path: AppRoute.intro)
// class IntroRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => false;

//   const IntroRoute() : super(const IntroView());
// }

// // ✅ 권한 체크 라우터
// @TypedGoRoute<PermissionCheckRoute>(path: AppRoute.permissionCheck)
// class PermissionCheckRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => false;

//   const PermissionCheckRoute()
//       : super(
//           const PermissionView(),
//         );
// }

// // ✅ 로그인 라우터
// @TypedGoRoute<LoginRoute>(path: AppRoute.signup)
// class LoginRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => false;

//   const LoginRoute() : super(const AuthView());
// }

// // ✅ 프로필 설정 라우터
// @TypedGoRoute<ProfileSettingRoute>(path: AppRoute.profileSetting)
// class ProfileSettingRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => false;

//   const ProfileSettingRoute() : super(const ProfileSettingView());
// }

// // ✅ 홈 라우터
// @TypedGoRoute<HomeRoute>(path: AppRoute.home)
// class HomeRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => true;

//   HomeRoute() : super(const MemoHomeView());
// }

// // ✅ 수정 라우터
// @TypedGoRoute<EditRoute>(path: AppRoute.edit)
// class EditRoute extends Route {
//   final MemoModel memo;

//   @override
//   bool checkAuth(BuildContext context) => true;

//   EditRoute({required this.memo}) : super(MemoEditView(memo: memo));
// }

// // ✅ 상세 라우터
// @TypedGoRoute<DetailEntryRoute>(
//   path: AppRoute.detail,
//   routes: [
//     TypedGoRoute<DetailRoute>(path: ':id'),
//   ],
// )
// class DetailEntryRoute extends Route {
//   const DetailEntryRoute() : super(const SizedBox.shrink());

//   @override
//   bool checkAuth(BuildContext context) => false;
// }

// class DetailRoute extends Route {
//   final String id;

//   DetailRoute(this.id) : super(MemoDetailView(id: id));

//   @override
//   bool checkAuth(BuildContext context) => true;
// }

// // ✅ 피드 라우터
// @TypedGoRoute<FeedRoute>(path: AppRoute.feed)
// class FeedRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => true;

//   const FeedRoute() : super(const FeedView());
// }

// // ✅ 삭제 라우터
// @TypedGoRoute<DeleteRoute>(path: AppRoute.delete)
// class DeleteRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => true;

//   const DeleteRoute() : super(const MemoDeleteView());
// }

// // ✅ 검색 라우터
// @TypedGoRoute<SearchRoute>(path: AppRoute.search)
// class SearchRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => true;

//   const SearchRoute() : super(const SearchView());
// }

// // ✅ 설정 라우터
// @TypedGoRoute<SettingsRoute>(path: AppRoute.settings)
// class SettingsRoute extends Route {
//   @override
//   bool checkAuth(BuildContext context) => true;

//   const SettingsRoute() : super(const SettingsView());
// }
