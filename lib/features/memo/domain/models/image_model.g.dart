// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageModelImpl _$$ImageModelImplFromJson(Map<String, dynamic> json) =>
    _$ImageModelImpl(
      index: (json['index'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$$ImageModelImplToJson(_$ImageModelImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
