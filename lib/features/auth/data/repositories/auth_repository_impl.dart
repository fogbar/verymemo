import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/auth/data/data-sources/firebase/firebase_service.dart';
// import 'package:verymemo/features/auth/data/datasources/supabase/supabase_service.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // final supabaseService = ref.watch(supabaseServiceProvider);
  final firebaseService = ref.watch(firebaseServiceProvider);
  return AuthRepositoryImpl(firebaseService);
});

class AuthRepositoryImpl implements AuthRepository {
  // final SupabaseService _supabaseService;
  final FirebaseService _firebaseService;

  AuthRepositoryImpl(this._firebaseService);
  @override
  Stream<UserModel?> authStateChanges() {
    // return _supabaseService.authStateChanges().map((user) => user);
    return _firebaseService.authStateChanges();
  }

  @override
  UserModel? getCurrentUser() {
    // return _supabaseService.getCurrentUser();
    return _firebaseService.getCurrentUser();
  }

  @override
  Future<UserModel?> signInWithApple() async {
    // return await _supabaseService.signInWithApple();
    return await _firebaseService.signInWithApple();
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    // return await _supabaseService.signInWithGoogle();
    return await _firebaseService.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    // await _supabaseService.signOut();
    await _firebaseService.signOut();
  }
}
