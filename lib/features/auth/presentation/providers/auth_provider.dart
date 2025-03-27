import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/configs/storage_key.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/domain/repositories/auth_repository.dart';
import 'package:verymemo/features/auth/presentation/providers/state/auth_state.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:verymemo/routers/router.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final storageService = ref.watch(storageProvider);
  final navigationService = ref.watch(navigationServiceProvider);
  return AuthStateNotifier(authRepository, storageService, navigationService);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;
  final NavigationService _navigationService;

  AuthStateNotifier(
      this._authRepository, this._storageService, this._navigationService)
      : super(
          const AuthState.initial(),
        );

  Future<void> signIn(String provider) async {
    try {
      state = const AuthState.loading();
      UserModel? user;

      // 기존 AuthProvider 가 두 곳에서 같은 이름으로 동시에 사용 중이었기에,
      // 도메인에 정의된 것으로 옮기고 처리.
      // enums 를 domain 폴더 내부에 파일을 분리해서 가져갈지
      // enum의 위치를 조절해보면 좋을 듯.
      // 또는 signIn 함수 하나로 통일하는 것이 아닌 공통 함수로 뺄 것 빼고
      // 구글, 애플 로그인 함수 각각 만드는 것도 좋다고 판단.
      switch (provider) {
        case "google":
          user = await _authRepository.signInWithGoogle();
        case "apple":
          user = await _authRepository.signInWithApple();
        default:
          user = null;
      }

      if (user != null) {
        state = AuthState.authenticated(user);
        await _storageService.set(key: userKey, data: user.toJson());
        _navigationService.go(AppRoute.home);
      } else {
        state = const AuthState.unauthenticated();
      }
      // final user = await _authRepository.sign
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      state = const AuthState.loading();
      UserModel? user = _authRepository.getCurrentUser();

      if (user != null) {
        switch (user.provider) {
          case AuthProvider.google:
            await _authRepository.signOutWithGoogle();
          case AuthProvider.apple:
            await _authRepository.signOutWithApple();
          case AuthProvider.unknown:
            state = AuthState.error("회원 탈퇴에 실패하였습니다.");
            return;
        }

        // 해당 유저 정보 삭제
        bool isRemoved = await _storageService.remove(key: userKey);

        log("❌ 해당 유저 정보 삭제 및 탈퇴: ${isRemoved ? "성공" : "실패"}");

        if (isRemoved) {
          // 회원가입 화면으로 라우팅
          _navigationService.go(AppRoute.signup);
        } else {
          state = AuthState.error("회원 탈퇴에 실패하였습니다.");
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      log("❌ 회원 탈퇴 오류: $e");
      state = AuthState.error("회원 탈퇴에 실패하였습니다.");
    }
  }

  // 현재 인증 상태 체크
  Future<void> checkAuthState() async {
    try {
      state = const AuthState.loading();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
