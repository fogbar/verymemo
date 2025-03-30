// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoModel _$MemoModelFromJson(Map<String, dynamic> json) => MemoModel(
      memoId: (json['memoId'] as num?)?.toInt(),
      profileImageUrl: json['profileImageUrl'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      content: json['content'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastViewedAt: json['lastViewedAt'] == null
          ? null
          : DateTime.parse(json['lastViewedAt'] as String),
      isLocalMemo: json['isLocalMemo'] as bool,
      isBookMarked: json['isBookMarked'] as bool,
    );

Map<String, dynamic> _$MemoModelToJson(MemoModel instance) => <String, dynamic>{
      'memoId': instance.memoId,
      'profileImageUrl': instance.profileImageUrl,
      'userId': instance.userId,
      'userName': instance.userName,
      'content': instance.content,
      'images': instance.images,
      'links': instance.links,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastViewedAt': instance.lastViewedAt?.toIso8601String(),
      'isLocalMemo': instance.isLocalMemo,
      'isBookMarked': instance.isBookMarked,
    };

LinkModel _$LinkModelFromJson(Map<String, dynamic> json) => LinkModel(
      linkId: (json['linkId'] as num?)?.toInt(),
      linkUrl: json['linkUrl'] as String?,
      thumbnail: json['thumbnail'] as String?,
      metaTitle: json['metaTitle'] as String?,
      metaDescription: json['metaDescription'] as String?,
    );

Map<String, dynamic> _$LinkModelToJson(LinkModel instance) => <String, dynamic>{
      'linkId': instance.linkId,
      'linkUrl': instance.linkUrl,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      imageId: (json['imageId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };

Map<String, dynamic> _$$MemoModelImplToJson(_$MemoModelImpl instance) =>
    <String, dynamic>{
      'memoId': instance.memoId,
      'profileImageUrl': instance.profileImageUrl,
      'userId': instance.userId,
      'userName': instance.userName,
      'content': instance.content,
      'images': instance.images,
      'links': instance.links,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastViewedAt': instance.lastViewedAt?.toIso8601String(),
      'isLocalMemo': instance.isLocalMemo,
      'isBookMarked': instance.isBookMarked,
    };

Map<String, dynamic> _$$LinkModelImplToJson(_$LinkModelImpl instance) =>
    <String, dynamic>{
      'linkId': instance.linkId,
      'linkUrl': instance.linkUrl,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };

Map<String, dynamic> _$$ImageModelImplToJson(_$ImageModelImpl instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      tagName: json['tagName'] as String?,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
    };
