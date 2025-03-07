// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoDTO _$MemoDTOFromJson(Map<String, dynamic> json) => MemoDTO(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      content: json['content'] as String?,
      isLocalMemo: (json['isLocalMemo'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MemoDTOToJson(MemoDTO instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'isLocalMemo': instance.isLocalMemo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Map<String, dynamic> _$$MemoDTOImplToJson(_$MemoDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'isLocalMemo': instance.isLocalMemo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
