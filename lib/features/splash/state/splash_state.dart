import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.loading() = _Loading;
  const factory SplashState.home() = _Home;
  const factory SplashState.intro() = _Intro;
  const factory SplashState.signup() = SignUp;
}
