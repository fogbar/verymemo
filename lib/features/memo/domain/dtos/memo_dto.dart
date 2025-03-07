import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'memo_dto.freezed.dart';
part 'memo_dto.g.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class MemoDTO with _$MemoDTO {
  const factory MemoDTO({
    int? id,
    String? userId,
    String? content,
    int? isLocalMemo, // 💡 0 또는 1
    String? createdAt,
    String? updatedAt,
    // @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
    // @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
    // @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
  }) = _MemoDTO;

  factory MemoDTO.fromJson(MAP json) => _$MemoDTOFromJson(json);

  @override
  MAP toJson() => _$MemoDTOToJson(this);
}
