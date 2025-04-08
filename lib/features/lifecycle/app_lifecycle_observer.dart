import 'package:flutter/material.dart';
import 'package:verymemo/features/lifecycle/lifecycle_provider.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final AppLifecycleNotifier _lifecycleNotifier;

  AppLifecycleObserver(this._lifecycleNotifier);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _lifecycleNotifier.onAppResume();
        break;
      case AppLifecycleState.paused:
        _lifecycleNotifier.onAppPause();
        break;
      case AppLifecycleState.inactive:
        _lifecycleNotifier.onAppInactive();
        break;
      case AppLifecycleState.hidden:
        _lifecycleNotifier.onAppDetached();
        break;
      default:
        break;
    }
  }
}
