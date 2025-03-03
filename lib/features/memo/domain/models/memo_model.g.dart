// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoModelImpl _$$MemoModelImplFromJson(Map<String, dynamic> json) =>
    _$MemoModelImpl(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String? ?? "",
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => LinkDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isLocalMemo: json['isLocalMemo'] as bool? ?? false,
    );

Map<String, dynamic> _$$MemoModelImplToJson(_$MemoModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'links': instance.links,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isLocalMemo': instance.isLocalMemo,
    };
