import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:verymemo/common/utils/string_util.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseService();

  // 사용자 정보 조회
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      return doc.exists
          ? UserModel.fromFirestore(doc.data()!)
          : UserModel.fromFBUser(user);
    } on FirebaseException catch (e) {
      throw Exception('Firestore 오류: ${e.message}');
    }
  }

  // FireStore에 저장된 유저 정보가 업데이트 될 떄마다 실시간으로 불리는 값
  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().asyncExpand((authUser) async* {
      if (authUser == null) {
        yield null;
      } else {
        // Firestore 문서 실시간 구독
        yield* _firestore
            .collection('users')
            .doc(authUser.uid)
            .snapshots()
            .map((doc) {
          if (!doc.exists) return UserModel.fromFBUser(authUser);
          return UserModel.fromFirestore(doc.data()!);
        });
      }
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

      await createNewUserDocument(credential, user, UserAuthProvider.google);

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
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential credential =
          await _auth.signInWithCredential(oauthCredential);
      final user = credential.user;

      if (user == null) return null;

      if (appleCredential.givenName != null) {
        // Firebase auth 유저 정보 업데이트
        await user.updateDisplayName(
            "${appleCredential.givenName} ${appleCredential.familyName}");

        // Firestore 유저 정보 업데이트
        await _firestore.collection('users').doc(user.uid).update({
          'displayName':
              "${appleCredential.givenName} ${appleCredential.familyName}",
        });
        // 업데이트된 사용자 정보 다시 가져오기
        await user.reload();
      }

      await createNewUserDocument(credential, user, UserAuthProvider.apple);

      return UserModel.fromFBUser(user);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw Exception("사용자가 Apple 로그인을 취소했습니다.");
      }
      throw Exception("Apple 로그인 인증 오류: ${e.message}");
    } catch (e) {
      throw Exception("---> signInWithApple Error: $e");
    }
  }

  // 임시 함수.
  // 향후 수정 필요. 반드시 수정 필요.
  Future<UserModel?> signInWithGuest() async {
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
          throw Exception('게스트 로그인이 활성화되지 않았습니다.');
        case 'user-disabled':
          throw Exception('사용자 계정이 비활성화되었습니다.');
        case 'user-not-found':
          throw Exception('사용자를 찾을 수 없습니다.');
        default:
          throw Exception('게스트 로그인 중 오류가 발생했습니다: ${e.message}');
      }
    } catch (e) {
      throw Exception("---> signInWithGuest Error: $e");
    }
  }

  Future<void> signOutWithGoogle() async {
    await Future.wait(
      [
        _auth.signOut(),
        _googleSignIn.signOut(),
      ],
    );
  }

  Future<void> signOutWithApple() async {
    await Future.wait(
      [
        _auth.signOut(),
      ],
    );
  }

  /// Firestore에 유저 정보 저장
  /// 신규 회원가입 일때만 저장.
  ///
  Future<void> createNewUserDocument(
    UserCredential credential,
    User user,
    UserAuthProvider authProvider,
  ) async {
    if (!(credential.additionalUserInfo?.isNewUser ?? false)) return;

    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'userType': UserType.anonymous.name, // 기본값 'anonymous'
      'photoUrl': user.photoURL,
      'authProvider': authProvider.name,
      'createdAt': FieldValue.serverTimestamp(),
      'lastSignInAt': FieldValue.serverTimestamp(), // 신규 필드 추가
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// FireStore에 저장된 유저 정보 업데이트 하는 함수
  /// 컬럼은 향후 추가될 수 있음.
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
    UserType? userType,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Firebase Auth 업데이트
    if (displayName != null) await user.updateDisplayName(displayName);
    if (photoUrl != null) await user.updatePhotoURL(photoUrl);

    // Firestore 업데이트
    final updateData = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (displayName != null) updateData['displayName'] = displayName;
    if (photoUrl != null) updateData['photoUrl'] = photoUrl;
    if (userType != null) updateData['userType'] = userType.name;

    await _firestore.collection('users').doc(user.uid).update(updateData);
  }
}
