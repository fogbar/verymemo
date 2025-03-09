part of 'model.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class ImageModel with _$ImageModel {
  const factory ImageModel({
    int? imageId, // 해당 image의 인덱스
    @Default("") String? imageUrl,
    @Default("") String? description, // 주석
  }) = _ImageModel;

  factory ImageModel.fromJson(MAP json) => _$ImageModelFromJson(json);
  factory ImageModel.empty() => ImageModel();
  @override
  MAP toJson() => _$ImageModelToJson(this);
}
