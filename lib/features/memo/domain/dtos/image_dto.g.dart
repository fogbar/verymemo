// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

Map<String, dynamic> _$$ImageDTOImplToJson(_$ImageDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memoId': instance.memoId,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
