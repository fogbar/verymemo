part of 'dto.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class LinkDTO with _$LinkDTO {
  const factory LinkDTO({
    int? id,
    int? memoId, // 💡 외래키
    required String linkUrl, // 💡 links 테이블의 url 컬럼
    String? thumbnail,
    String? metaTitle,
    String? metaDescription,
  }) = _LinkDTO;

  factory LinkDTO.fromJson(MAP json) => _$LinkDTOFromJson(json);

  @override
  MAP toJson() => _$LinkDTOToJson(this);
}
