import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.intro() = _Intro;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserModel user) = _Authenticated;
  const factory AuthState.unauthenticated() = _UnAuthenticated;
  const factory AuthState.error(String message) = _Error;
}

// 무조건 첫 시작은 initial : initial (스플래쉬 뷰를 보여주면 된다.)
// 유저가 intro로도 보지 않은 상태 : intro
// 회원 가입 or 탈퇴 중 -> loading 중 임을 보여주어야 할 때 : loading
// 회원 가입 및 로그인 완료 : authenticated
// 회원 탈퇴 완료. : unauthenticated
// 에러 발생. : error
