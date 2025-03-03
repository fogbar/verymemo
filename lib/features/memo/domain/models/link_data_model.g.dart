// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinkDataModelImpl _$$LinkDataModelImplFromJson(Map<String, dynamic> json) =>
    _$LinkDataModelImpl(
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String? ?? "",
      metaTitle: json['metaTitle'] as String? ?? "",
      metaDescription: json['metaDescription'] as String? ?? "",
    );

Map<String, dynamic> _$$LinkDataModelImplToJson(_$LinkDataModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
    };
