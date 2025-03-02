import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:verymemo/features/settings/providers/theme_providers.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, SettingsState>((ref) {
  return SettingsViewModel(ref);
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
  final Ref ref;

  SettingsViewModel(this.ref) : super(SettingsState());

  void toggleKeypad(bool value) {
    state = state.copyWith(isKeypadEnabled: value);
    // TODO: 필요한 경우 저장 로직 추가
  }

  void toggleDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
    ref.read(isDarkModeProvider.notifier).state = value;
  }

  void onSyncTap() {
    // TODO: 동기화 로직 구현
    debugPrint("동기화 실행");
  }

  void onDeletedMemosTap() {
    // TODO: 삭제된 메모 페이지로 이동
    debugPrint("삭제된 메모 페이지로 이동");
  }

  // void onAppReviewTap() {
  //   // TODO: 앱 스토어 리뷰 페이지 열기
  //   debugPrint("앱 리뷰 페이지 열기");
  // }

  // void onOpenChatTap() {
  //   // TODO: 오픈 카톡 링크 열기
  //   debugPrint("오픈 카톡 링크 열기");
  // }

  void onVersionInfoTap() {
    // TODO: 버전 정보 다이얼로그 표시
    debugPrint("버전 정보 표시");
  }

  void onWithdrawalTap() {
    // TODO: 회원 탈퇴 다이얼로그 표시
    debugPrint("회원 탈퇴 표시");
  }
}
