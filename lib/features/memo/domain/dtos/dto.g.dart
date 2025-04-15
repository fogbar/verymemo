// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoDTO _$MemoDTOFromJson(Map<String, dynamic> json) => MemoDTO(
      id: (json['id'] as num?)?.toInt(),
      docId: json['docId'] as String?,
      userId: json['userId'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      lastViewedAt: json['lastViewedAt'] as String?,
      isLocalMemo: (json['isLocalMemo'] as num?)?.toInt(),
      isBookMarked: (json['isBookMarked'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MemoDTOToJson(MemoDTO instance) => <String, dynamic>{
      'id': instance.id,
      'docId': instance.docId,
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'lastViewedAt': instance.lastViewedAt,
      'isLocalMemo': instance.isLocalMemo,
      'isBookMarked': instance.isBookMarked,
    };

ImageDTO _$ImageDTOFromJson(Map<String, dynamic> json) => ImageDTO(
      id: (json['id'] as num?)?.toInt(),
      memoId: (json['memoId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ImageDTOToJson(ImageDTO instance) => <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };

LinkDTO _$LinkDTOFromJson(Map<String, dynamic> json) => LinkDTO(
      id: (json['id'] as num?)?.toInt(),
      memoId: (json['memoId'] as num?)?.toInt(),
      linkUrl: json['linkUrl'] as String,
      thumbnail: json['thumbnail'] as String?,
      metaTitle: json['metaTitle'] as String?,
      metaDescription: json['metaDescription'] as String?,
    );

Map<String, dynamic> _$LinkDTOToJson(LinkDTO instance) => <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'linkUrl': instance.linkUrl,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };

TagDTO _$TagDTOFromJson(Map<String, dynamic> json) => TagDTO(
      id: (json['id'] as num?)?.toInt(),
      tagName: json['tagName'] as String?,
    );

Map<String, dynamic> _$TagDTOToJson(TagDTO instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };

Map<String, dynamic> _$$MemoDTOImplToJson(_$MemoDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'docId': instance.docId,
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'lastViewedAt': instance.lastViewedAt,
      'isLocalMemo': instance.isLocalMemo,
      'isBookMarked': instance.isBookMarked,
    };

Map<String, dynamic> _$$ImageDTOImplToJson(_$ImageDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };

Map<String, dynamic> _$$LinkDTOImplToJson(_$LinkDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'linkUrl': instance.linkUrl,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };

Map<String, dynamic> _$$TagDTOImplToJson(_$TagDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };
