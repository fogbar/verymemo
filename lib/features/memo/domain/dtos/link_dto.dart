import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'link_dto.g.dart';
part 'link_dto.freezed.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class LinkDTO with _$LinkDTO {
  const factory LinkDTO({
    int? id,
    int? memoId, // 💡 외래키
    required String url, // 💡 links 테이블의 url 컬럼
    String? thumbnail,
    String? metaTitle,
    String? metaDescription,
  }) = _LinkDTO;

  factory LinkDTO.fromJson(MAP json) => _$LinkDTOFromJson(json);

  @override
  MAP toJson() => _$LinkDTOToJson(this);
}
