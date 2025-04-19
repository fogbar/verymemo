import 'package:cloud_firestore/cloud_firestore.dart';
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

// firebase의 user에서도 AuthProvider라는 이름을 사용하여
// 혼동이와 UserAuthProvider 로 수정
enum UserAuthProvider {
  google, // 구글 로그인
  apple, // 애플 로그인
  unknown; // 비회원 로그인

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
    required UserAuthProvider authProvider,
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
    UserAuthProvider provider = UserAuthProvider.unknown;
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
    UserAuthProvider provider = UserAuthProvider.unknown;

    print("user.providerData: ${user.providerData}");

    if (user.providerData.isNotEmpty) {
      switch (user.providerData[0].providerId) {
        case 'google.com':
          provider = UserAuthProvider.google;
          break;
        case 'apple.com':
          provider = UserAuthProvider.apple;
          break;
        default:
          provider = UserAuthProvider.unknown;
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

  // FireStore에 저장된 유저 데이터 가져오는 factory 함수
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      userType: UserType.values.firstWhere(
        (e) => e.name == data['userType'],
        orElse: () => UserType.free,
      ),
      photoUrl: data['photoUrl'],
      authProvider: UserAuthProvider.values.firstWhere(
        (e) => e.name == data['authProvider'],
        orElse: () => UserAuthProvider.unknown,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastSignInAt: data['lastSignInAt'] != null
          ? (data['lastSignInAt'] as Timestamp).toDate()
          : null,
    );
  }
}
