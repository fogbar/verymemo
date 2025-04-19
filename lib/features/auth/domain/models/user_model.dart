import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:collection/collection.dart';

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

/// 유저가 선택한 동기화 방식
enum UserSyncType {
  firestore, // firestore에 동기화
  cloud, // cloud에 동기화
}

// UserModel 변경시 firebase_service의 createNewUserDocument 도 수정해주기.
// 향후에는 이것도 UserModel 하나로 처리되게끔 해야 함.
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
    required bool? isSynced, // 동기화 진행하는지 확인
    required UserSyncType?
        syncType, // 유저가 동기화를 진행한 타입 (isSynced가 true여야만 해당 값 들어감)
  }) = _UserModel;

  /// ✅ computed properties
  bool get isPremium => userType == UserType.premium;

  int get imageUploadLimit => userType.imageUploadLimit;

  bool get canSync => userType.canSync;

  bool get canShareMemo => userType.canShareMemo;

  // noSql 특징에 따라 키 값이 저장되어 있든 안되어 있든 항상 저장됨.
  // 그러다보니 fromJson에서 이슈가 날 수 있음.
  // 향후 컬럼 추가될 경우 여기서 null 처리 필수
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // isSynced 파싱 로직 추가
    bool? isSynced;
    if (json['isSynced'] == null) {
      isSynced = false; // 기본값
    } else if (json['isSynced'] is bool) {
      isSynced = json['isSynced'] as bool;
    } else if (json['isSynced'] is String) {
      // "true", "false" 문자열을 bool로 변환
      isSynced = json['isSynced'] == 'true';
    } else {
      isSynced = false; // 예외 상황 기본값
    }

    // syncType도 값 확인
    UserSyncType? syncType = json['syncType'] != null
        ? UserSyncType.values
            .firstWhereOrNull((e) => e.name == json['syncType'])
        : null;

    // 나머지는 기존 로직 사용
    return _$UserModelFromJson({
      ...json,
      'isSynced': isSynced,
      'syncType': syncType,
    });
  }

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
      isSynced: false,
      syncType: null,
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
      isSynced: false,
      syncType: null,
    );
  }

  // FireStore에 저장된 유저 데이터 가져오는 factory 함수
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    // Enum 파싱
    UserType userType = UserType.values.firstWhere(
      (e) => e.name == data['userType'],
      orElse: () => UserType.free,
    );
    UserAuthProvider authProvider = UserAuthProvider.values.firstWhere(
      (e) => e.name == data['authProvider'],
      orElse: () => UserAuthProvider.unknown,
    );

    // isSynced 파싱 로직 추가
    bool? isSynced;
    if (data['isSynced'] == null) {
      isSynced = false; // 기본값
    } else if (data['isSynced'] is bool) {
      isSynced = data['isSynced'] as bool;
    } else if (data['isSynced'] is String) {
      // "true", "false" 문자열을 bool로 변환
      isSynced = data['isSynced'] == 'true';
    } else {
      isSynced = false; // 예외 상황 기본값
    }

    UserSyncType? syncType = data['syncType'] != null
        ? UserSyncType.values
            .firstWhereOrNull((e) => e.name == data['syncType'])
        : null;

    return UserModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      userType: userType,
      photoUrl: data['photoUrl'],
      authProvider: authProvider,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastSignInAt: data['lastSignInAt'] != null
          ? (data['lastSignInAt'] as Timestamp).toDate()
          : null,
      isSynced: isSynced,
      syncType: syncType,
    );
  }
}
