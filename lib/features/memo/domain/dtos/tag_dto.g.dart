// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagDTO _$TagDTOFromJson(Map<String, dynamic> json) => TagDTO(
      id: (json['id'] as num?)?.toInt(),
      tagName: json['tagName'] as String?,
    );

Map<String, dynamic> _$TagDTOToJson(TagDTO instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };

Map<String, dynamic> _$$TagDTOImplToJson(_$TagDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
    };
