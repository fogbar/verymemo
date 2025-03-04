import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:verymemo/common/utils/string_util.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseService();

  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserModel.fromFBUser(user);
  }

  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFBUser(user);
    });
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) return null;

      final GoogleSignInAuthentication authentication =
          await account.authentication;

      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );

      UserCredential credential =
          await _auth.signInWithCredential(googleCredential);

      final user = credential.user;
      if (user == null) return null;

      return UserModel.fromFBUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          throw Exception('이미 다른 방법으로 가입된 계정입니다.');
        case 'invalid-credential':
          throw Exception('인증 정보가 유효하지 않습니다.');
        case 'operation-not-allowed':
          throw Exception('Google 로그인이 활성화되지 않았습니다.');
        case 'user-disabled':
          throw Exception('사용자 계정이 비활성화되었습니다.');
        case 'user-not-found':
          throw Exception('사용자를 찾을 수 없습니다.');
        default:
          throw Exception('Google 로그인 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      throw Exception("---> signInWithGoogle Error: $e");
    }
  }

  Future<UserModel?> signInWithApple() async {
    try {
      final rawNonce = StringUtil.generateNonce();
      final nonce = StringUtil.sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (appleCredential.givenName != null && user != null) {
        await user.updateDisplayName(
            "${appleCredential.givenName} ${appleCredential.familyName}");
        // 업데이트된 사용자 정보 다시 가져오기
        await user.reload();
      }

      // 최종 사용자 정보 반환
      if (user != null) {
        return UserModel.fromFBUser(user);
      }

      return null;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw Exception("사용자가 Apple 로그인을 취소했습니다.");
      }
      throw Exception("Apple 로그인 인증 오류: ${e.message}");
    } catch (e) {
      throw Exception("---> signInWithApple Error: $e");
    }
  }

  Future<void> signOut() async {
    await Future.wait(
      [
        _auth.signOut(),
        _googleSignIn.signOut(),
      ],
    );
  }
}
