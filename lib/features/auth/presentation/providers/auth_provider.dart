import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/common/utils/json_util.dart';
import 'package:verymemo/common/utils/platform_util.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verymemo/externals/storage/storage_service.dart';
import 'package:verymemo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/domain/repositories/auth_repository.dart';
import 'package:verymemo/features/auth/presentation/providers/state/auth_state.dart';
import 'package:verymemo/features/auth/presentation/providers/user_provider.dart';
import 'package:verymemo/features/permission/providers/permission_provider.dart';
import 'package:verymemo/routers/navigation_service.dart';
import 'package:verymemo/routers/router.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final storageService = ref.watch(storageProvider);
  final navigationService = ref.watch(navigationServiceProvider);
  final userNotifierProvider = ref.watch(userProvider.notifier);
  final permissionProvider = ref.watch(permissionNotifierProvider.notifier);
  return AuthStateNotifier(authRepository, storageService, navigationService,
      userNotifierProvider, permissionProvider);
});

// 유저의 회원가입/로그인 상태 체크
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;
  final NavigationService _navigationService;
  final UserNotifier _userNotifier;
  final PermissionNotifier _permissionProvider;

  AuthStateNotifier(this._authRepository, this._storageService,
      this._navigationService, this._userNotifier, this._permissionProvider)
      : super(const AuthState.initial()) {
    _init();
  }

  /// 1. DeviceId가 저장되어 있는지 체크
  ///  - O
  ///   - UserModel이 저장되어 있는지 체크
  ///     - O
  ///       - 회원 / 비회원 -> 저장된 UserModel을 메모리에 올림
  ///       - AppRoute.home 으로 보냄
  ///     - X : 최초는 X, 가입정보 입력 X
  ///       - AppRoute.auth로 보내버림
  ///
  ///   - X : 최초 접근인 경우
  ///    -> AppRoute.intro 로 보내버림

  // Init
  Future<void> _init() async {
    final deviceId = await PlatformUtil.getPlatformInfo();

    final user = await _storageService.get(key: userKey);

    // permission 체크 진행.
    if (await _permissionProvider.shouldNavigateToPermission()) {
      print("퍼미션 체크로 이동해야 함");
      // permission 체크가 최상위에 한 번 진행.
      _navigationService.pushAndRemoveUntil(AppRoute.permissionCheck);
    } else {
      // permission 체크 이미 함.
      // 해당 deviceId가 로컬 DB에 저장되어 있는지 확인
      if (await containsValue(deviceId)) {
        // O
        // 유저모델 저장 여부
        // O
        if (user != null && user != "") {
          _userNotifier.saveUser(
            UserModel.fromFirestore(
              JsonUtil.stringToJson(
                user.toString(),
              ),
            ),
          );

          // 정상 로그인
          state = AuthState.authenticated(_userNotifier.getUser()!);
          _navigationService.pushAndRemoveUntil(AppRoute.home);
        } else {
          // 유저가 인트로까지는 봤는데 회원가입/로그인을 안했을때.
          state = const AuthState.unauthenticated();
          _navigationService.pushAndRemoveUntil(AppRoute.signup);
        }
      } else {
        // 유저가 앱 깔자마자 처음 들어왔을때.
        // 그 이후에는 타면 안 됨.
        state = AuthState.intro();
        _navigationService.pushAndRemoveUntil(AppRoute.intro);
      }
    }
  }

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
        case "guest":
          // 게스트로 가입시 home 으로 리다이렉트
          // 향후 해당 부분 구현 필요.
          _navigationService.pushAndRemoveUntil(AppRoute.home);
          return;
        default:
          user = null;
      }

      if (user != null) {
        state = AuthState.authenticated(user);
        _userNotifier.saveUser(user);
        await _storageService.set(key: userKey, data: user.toJson());
        _navigationService.pushAndRemoveUntil(AppRoute.home);
      } else {
        state = const AuthState.unauthenticated();
        _navigationService.pushAndRemoveUntil(AppRoute.signup);
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      state = const AuthState.loading();
      UserModel? user = await _authRepository.getCurrentUser();

      if (user != null) {
        switch (user.authProvider) {
          case UserAuthProvider.google:
            await _authRepository.signOutWithGoogle();
          case UserAuthProvider.apple:
            await _authRepository.signOutWithApple();
          case UserAuthProvider.unknown:
            state = AuthState.error("회원 탈퇴에 실패하였습니다.");
            return;
        }

        // 해당 유저 정보 삭제
        bool isRemoved = await _storageService.remove(key: userKey);

        log("❌ 해당 유저 정보 삭제 및 탈퇴: ${isRemoved ? "성공" : "실패"}");

        if (isRemoved) {
          // 회원가입 화면으로 라우팅
          _userNotifier.removeUser();
          state = const AuthState.unauthenticated();
          await _storageService.remove(key: userKey);
          _navigationService.pushAndRemoveUntil(AppRoute.signup);
        } else {
          state = AuthState.error("회원 탈퇴에 실패하였습니다.");
        }
      } else {
        log("❌ 회원 탈퇴 오류");
        state = AuthState.error("존재하지 않는 유저 입니다.");
      }
    } catch (e) {
      log("❌ 회원 탈퇴 오류: $e");
      state = AuthState.error("회원 탈퇴에 실패하였습니다.");
    }
  }

  Future<void> logout() async {
    try {
      state = const AuthState.loading();
      UserModel? user = await _authRepository.getCurrentUser();

      if (user != null) {
        switch (user.authProvider) {
          case UserAuthProvider.google:
            await _authRepository.signOutWithGoogle();
          case UserAuthProvider.apple:
            await _authRepository.signOutWithApple();
          case UserAuthProvider.unknown:
            state = AuthState.error("로그아웃에 실패하였습니다.");
            return;
        }

        // 회원가입 화면으로 라우팅
        _userNotifier.removeUser();
        state = const AuthState.unauthenticated();
        await _storageService.remove(key: userKey);
        _navigationService.pushAndRemoveUntil(AppRoute.signup);
      } else {
        log("❌ 회원 탈퇴 오류");
        state = AuthState.error("존재하지 않는 유저 입니다.");
      }
    } catch (e) {
      log("❌ 로그아웃 오류: $e");
      state = AuthState.error("로그아웃에 실패하였습니다.");
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

  // Device Info 가져오기
  Future<bool> containsValue(String targetValue) async {
    final keys = await _storageService.getKeys();

    for (String key in keys) {
      final value = await _storageService.get(key: key);
      if (value == targetValue) {
        log("---> targetValue: $targetValue");
        return true;
      }
    }
    return false;
  }

  Future<void> updateUserIsSynced({
    bool? isSynced,
    UserSyncType? syncType,
  }) async {
    await _authRepository.updateUserProfile(
      isSynced: isSynced,
      syncType: syncType,
    );
  }

  Future<void> refreshUser() async {
    try {
      UserModel? updatedUser = await _authRepository.getCurrentUser();
      if (updatedUser != null) {
        // 상태 갱신
        state = AuthState.authenticated(updatedUser);
        // 유저 프로바이더 업데이트
        _userNotifier.saveUser(updatedUser);
        // 로컬 스토리지 저장
        await _storageService.set(key: userKey, data: updatedUser.toJson());
        log("✅ 유저 정보 갱신 완료: ${updatedUser.toJson()}");
      }
    } catch (e) {
      log("❌ 유저 정보 갱신 실패: $e");
      throw Exception("유저 정보 갱신 실패");
    }
  }
}
