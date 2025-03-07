// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoModel _$MemoModelFromJson(Map<String, dynamic> json) => MemoModel(
      memoId: (json['memoId'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      content: json['content'] as String,
      imageUrls: _imageUrlsFromJson(json['imageUrls']),
      links: _linksFromJson(json['links']),
      tags: _tagsFromJson(json['tags']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isLocalMemo: (json['isLocalMemo'] as num).toInt(),
    );

Map<String, dynamic> _$MemoModelToJson(MemoModel instance) => <String, dynamic>{
      'memoId': instance.memoId,
      'userId': instance.userId,
      'content': instance.content,
      'imageUrls': _imageUrlsToJson(instance.imageUrls),
      'links': _linksToJson(instance.links),
      'tags': _tagsToJson(instance.tags),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isLocalMemo': instance.isLocalMemo,
    };

Map<String, dynamic> _$$MemoModelImplToJson(_$MemoModelImpl instance) =>
    <String, dynamic>{
      'memoId': instance.memoId,
      'userId': instance.userId,
      'content': instance.content,
      'imageUrls': _imageUrlsToJson(instance.imageUrls),
      'links': _linksToJson(instance.links),
      'tags': _tagsToJson(instance.tags),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isLocalMemo': instance.isLocalMemo,
    };
