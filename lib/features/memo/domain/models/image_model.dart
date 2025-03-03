import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  const factory ImageModel({
    int? index, // 해당 image의 인덱스
    @Default("") String imageUrl,
    @Default("") String description, // 주석
  }) = _ImageModel;

  factory ImageModel.fromJson(MAP json) => _$ImageModelFromJson(json);
}
