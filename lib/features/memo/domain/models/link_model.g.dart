// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

Map<String, dynamic> _$$LinkModelImplToJson(_$LinkModelImpl instance) =>
    <String, dynamic>{
      'linkId': instance.linkId,
      'linkUrl': instance.linkUrl,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };
