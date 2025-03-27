import 'package:verymemo/features/auth/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithApple();
  Future<void> signOutWithGoogle();
  Future<void> signOutWithApple();
  Stream<UserModel?> authStateChanges();
  UserModel? getCurrentUser();
}

// 인증 결과를 나타내는 sealed class
