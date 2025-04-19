// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      photoUrl: json['photoUrl'] as String?,
      authProvider:
          $enumDecode(_$UserAuthProviderEnumMap, json['authProvider']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'photoUrl': instance.photoUrl,
      'authProvider': _$UserAuthProviderEnumMap[instance.authProvider]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.anonymous: 'anonymous',
  UserType.free: 'free',
  UserType.premium: 'premium',
};

const _$UserAuthProviderEnumMap = {
  UserAuthProvider.google: 'google',
  UserAuthProvider.apple: 'apple',
  UserAuthProvider.unknown: 'unknown',
};
