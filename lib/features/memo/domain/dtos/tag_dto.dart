import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'tag_dto.g.dart';
part 'tag_dto.freezed.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class TagDTO with _$TagDTO {
  const factory TagDTO({
    int? id,
    String? tagName, // 💡 tags 테이블의 tagName 컬럼
  }) = _TagDTO;

  factory TagDTO.fromJson(MAP json) => _$TagDTOFromJson(json);

  @override
  MAP toJson() => _$TagDTOToJson(this);
}
