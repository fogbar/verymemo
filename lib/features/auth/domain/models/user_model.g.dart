// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      provider: $enumDecode(_$AuthProviderEnumMap, json['provider']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSignInAt: json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'provider': _$AuthProviderEnumMap[instance.provider]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
    };

const _$AuthProviderEnumMap = {
  AuthProvider.google: 'google',
  AuthProvider.apple: 'apple',
  AuthProvider.unknown: 'unknown',
};

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'provider': _$AuthProviderEnumMap[instance.provider]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
    };
