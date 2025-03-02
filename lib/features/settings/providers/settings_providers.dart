import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/settings_viewmodel.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, SettingsState>((ref) {
  return SettingsViewModel(ref);
});
