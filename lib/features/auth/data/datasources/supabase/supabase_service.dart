// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:verymemo/features/auth/domain/models/user_model.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// final supabaseServiceProvider = Provider<SupabaseService>((ref) {
//   final supabaseClient = Supabase.instance.client;
//   final googleSignIn = GoogleSignIn();
//   return SupabaseService(
//     supabaseClient: supabaseClient,
//     googleSignIn: googleSignIn,
//   );
// });

// class SupabaseService {
//   final SupabaseClient _supabaseClient;
//   final GoogleSignIn _googleSignIn;

//   SupabaseService({
//     required SupabaseClient supabaseClient,
//     required GoogleSignIn googleSignIn,
//   })  : _supabaseClient = supabaseClient,
//         _googleSignIn = googleSignIn;

//   UserModel? getCurrentUser() {
//     final user = _supabaseClient.auth.currentUser;
//     if (user == null) return null;
//     return UserModel.fromSupabaseUser(user);
//   }

//   Future<UserModel> signInWithGoogle() async {
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) throw Exception("Google 로그인 취소");

//       final googleAuth = await googleUser.authentication;
//       final accessToken = googleAuth.accessToken;
//       final idToken = googleAuth.idToken;

//       if (accessToken == null || idToken == null) {
//         throw Exception("Google 로그인 실패");
//       }

//       final response = await _supabaseClient.auth.signInWithIdToken(
//         provider: OAuthProvider.google,
//         idToken: idToken,
//         accessToken: accessToken,
//       );
//       return UserModel.fromSupabaseUser(response.user!);
//     } catch (e) {
//       throw Exception("Google 로그인 실패: $e");
//     }
//   }

//   Future<UserModel> signInWithApple() async {
//     try {
//       final rawNonce = _supabaseClient.auth.generateRawNonce();
//       final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: hashedNonce,
//       );

//       final idToken = credential.identityToken;
//       if (idToken == null) throw Exception("Apple 로그인 실패");

//       final response = await _supabaseClient.auth.signInWithIdToken(
//         provider: OAuthProvider.apple,
//         idToken: idToken,
//         nonce: rawNonce,
//       );

//       return UserModel.fromSupabaseUser(response.user!);
//     } catch (e) {
//       throw Exception("Apple 로그인 실패: $e");
//     }
//   }

//   Future<void> signOut() async {
//     await Future.wait(
//       [
//         _supabaseClient.auth.signOut(),
//         _googleSignIn.signOut(),
//       ],
//     );
//   }

//   Stream<UserModel?> authStateChanges() {
//     return _supabaseClient.auth.onAuthStateChange.map((event) {
//       final user = event.session?.user;
//       if (user == null) return null;
//       return UserModel.fromSupabaseUser(user);
//     });
//   }
// }
