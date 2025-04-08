import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/auth/presentation/providers/auth_provider.dart';
import 'package:verymemo/features/auth/presentation/providers/state/user_state.dart';
import 'package:verymemo/features/settings/providers/theme_providers.dart';
import 'package:verymemo/features/settings/presentation/modals/withdrawal_modal.dart';
import 'package:verymemo/features/settings/presentation/modals/sync_modal.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:verymemo/routers/router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verymemo/features/auth/data/data-sources/firebase/firebase_service.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, SettingsState>((ref) {
  final navigationService = ref.watch(navigationServiceProvider);
  final firebaseService = ref.watch(firebaseServiceProvider);
  return SettingsViewModel(firebaseService, navigationService, ref);
});

class SettingsState {
  final bool isKeypadEnabled;
  final bool isDarkMode;
  // 필요한 다른 설정들...

  SettingsState({
    this.isKeypadEnabled = false,
    this.isDarkMode = false,
  });

  SettingsState copyWith({
    bool? isKeypadEnabled,
    bool? isDarkMode,
  }) {
    return SettingsState(
      isKeypadEnabled: isKeypadEnabled ?? this.isKeypadEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class SettingsViewModel extends StateNotifier<SettingsState> {
  final FirebaseService _firebaseService;
  final NavigationService _navigationService;
  final Ref ref;

  SettingsViewModel(
    this._firebaseService,
    this._navigationService,
    this.ref,
  ) : super(SettingsState(
          isDarkMode: false,
        ));

  void toggleKeypad(bool value) {
    state = state.copyWith(isKeypadEnabled: value);
    // TODO: 필요한 경우 저장 로직 추가
  }

  void toggleDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
    ref.read(isDarkModeProvider.notifier).state = value;
  }

  void onSyncTap(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.scrim,
      useSafeArea: true,
      builder: (context) => Theme(
        data: Theme.of(context),
        child: const SyncModal(),
      ),
    );
  }

  void onDeletedMemosTap(BuildContext context) {
    context.push(AppRoute.delete);
  }

  // void onAppReviewTap() {
  //   // TODO: 앱 스토어 리뷰 페이지 열기
  //   debugPrint("앱 리뷰 페이지 열기");
  // }

  void onOpenChatTap() async {
    final Uri url = Uri.parse('https://open.kakao.com/o/gNe0qKLg');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void onVersionInfoTap() {
    // TODO: 버전 정보 다이얼로그 표시
    debugPrint("버전 정보 표시");
  }

  void onWithdrawalTap(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.scrim,
      useSafeArea: true,
      builder: (context) => Theme(
        data: Theme.of(context),
        child: WithdrawalModal(
          onConfirm: () {
            debugPrint('Delete confirmed');

            ref.read(authStateNotifierProvider.notifier).signOut();

            // Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void logout() {
    ref.read(authStateNotifierProvider.notifier).logout();
  }

  void moveToSignUp() {
    debugPrint('settings_viewmodel moveToSignUp');

    _navigationService.pushAndRemoveUntil(AppRoute.signup);
  }
}
