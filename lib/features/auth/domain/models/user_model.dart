import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserType {
  anonymous(
    imageUploadLimit: 3,
    canSync: false,
    canShareMemo: false,
  ),
  free(
    imageUploadLimit: 3,
    canSync: true,
    canShareMemo: true,
  ),
  premium(
    imageUploadLimit: -1, // 무제한을 -1로 표현
    canSync: true,
    canShareMemo: true,
  );

  final int imageUploadLimit;
  final bool canSync;
  final bool canShareMemo;

  const UserType({
    required this.imageUploadLimit,
    required this.canSync,
    required this.canShareMemo,
  });
}

enum AuthProvider {
  google,
  apple,
  unknown;

  String get name => toString().split('.').last;
}

@freezed
class UserModel with _$UserModel {
  const UserModel._(); // ✅ 커스텀 getter를 위해 생성자 추가

  const factory UserModel({
    required String uid,
    required String email,
    required String displayName,
    required UserType userType,
    String? photoUrl,
    required AuthProvider authProvider,
    required DateTime createdAt,
    DateTime? lastSignInAt,
  }) = _UserModel;

  /// ✅ computed properties
  bool get isPremium => userType == UserType.premium;

  int get imageUploadLimit => userType.imageUploadLimit;

  bool get canSync => userType.canSync;

  bool get canShareMemo => userType.canShareMemo;

  factory UserModel.fromJson(MAP json) => _$UserModelFromJson(json);

  factory UserModel.empty() {
    AuthProvider provider = AuthProvider.unknown;
    return UserModel(
      uid: "",
      email: "",
      displayName: "",
      userType: UserType.anonymous,
      photoUrl: "",
      authProvider: provider,
      createdAt: DateTime.now(),
      lastSignInAt: null,
    );
  }
  factory UserModel.fromFBUser(fb.User user) {
    AuthProvider provider = AuthProvider.unknown;
    if (user.providerData.isNotEmpty) {
      switch (user.providerData[0].providerId) {
        case 'google.com':
          provider = AuthProvider.google;
          break;
        case 'apple.com':
          provider = AuthProvider.apple;
          break;
        default:
          provider = AuthProvider.unknown;
      }
    }
    return UserModel(
      uid: user.uid,
      email: user.email ?? "",
      displayName: user.displayName ?? "",
      userType: UserType.anonymous,
      photoUrl: user.photoURL,
      authProvider: provider,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastSignInAt: user.metadata.lastSignInTime,
    );
  }
}
