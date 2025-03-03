import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';

part 'writing_provider.g.dart';

@riverpod
class WritingState extends _$WritingState {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

@riverpod
class WritingMenuState extends _$WritingMenuState {
  @override
  ButtonState build() => ButtonState.disabled;

  void setUploadButtonState(String text) {
    state = text.trim().isNotEmpty ? ButtonState.primary : ButtonState.disabled;
  }
}
