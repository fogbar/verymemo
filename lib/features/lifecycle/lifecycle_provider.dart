import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppState { initializing, running, paused, inactive, detached }

class AppLifecycleNotifier extends StateNotifier<AppState> {
  AppLifecycleNotifier() : super(AppState.initializing);

  void onAppStart() {
    state = AppState.running;
  }

  void onAppPause() {
    state = AppState.paused;
  }

  void onAppResume() {
    state = AppState.running;
  }

  void onAppInactive() {
    state = AppState.inactive;
  }

  void onAppDetached() {
    state = AppState.detached;
  }
}

final appLifecycleProvider =
    StateNotifierProvider<AppLifecycleNotifier, AppState>((ref) {
  return AppLifecycleNotifier();
});
