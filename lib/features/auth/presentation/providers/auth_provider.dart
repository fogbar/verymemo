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

enum AuthProvider {
  google,
  apple;

  String get name => toString().split('.').last;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;
  final NavigationService _navigationService;

  AuthStateNotifier(
      this._authRepository, this._storageService, this._navigationService)
      : super(
          const AuthState.initial(),
        );

  Future<void> signIn(AuthProvider provider) async {
    try {
      state = const AuthState.loading();
      UserModel? user;

      switch (provider) {
        case AuthProvider.google:
          user = await _authRepository.signInWithGoogle();
        case AuthProvider.apple:
          user = await _authRepository.signInWithApple();
      }

      if (user != null) {
        state = AuthState.authenticated(user);
        await _storageService.set(key: userKey, data: user.toJson());
        _navigationService.go(AppRoute.permissionCheck);
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
    } catch (e) {
      state = AuthState.error(e.toString());
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
