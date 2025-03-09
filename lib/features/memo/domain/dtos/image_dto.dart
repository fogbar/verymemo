part of 'dto.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class ImageDTO with _$ImageDTO {
  const factory ImageDTO({
    int? id,
    int? memoId, // 💡 외래키
    required String imageUrl, // 💡 images 테이블의 imageUrl 컬럼
    String? description,
  }) = _ImageDTO;

  factory ImageDTO.fromJson(MAP json) => _$ImageDTOFromJson(json);
  @override
  MAP toJson() => _$ImageDTOToJson(this);
}
