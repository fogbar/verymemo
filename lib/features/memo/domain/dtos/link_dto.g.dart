// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkDTO _$LinkDTOFromJson(Map<String, dynamic> json) => LinkDTO(
      id: (json['id'] as num?)?.toInt(),
      memoId: (json['memoId'] as num?)?.toInt(),
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String?,
      metaTitle: json['metaTitle'] as String?,
      metaDescription: json['metaDescription'] as String?,
    );

Map<String, dynamic> _$LinkDTOToJson(LinkDTO instance) => <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };

Map<String, dynamic> _$$LinkDTOImplToJson(_$LinkDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };
