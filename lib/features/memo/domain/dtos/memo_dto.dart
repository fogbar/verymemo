part of 'dto.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class MemoDTO with _$MemoDTO {
  const factory MemoDTO({
    int? id,
    String? userId,
    String? content,
    String? createdAt,
    String? updatedAt,
    // @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
    // @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
    // @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
    int? isLocalMemo, // 💡 0 또는 1
    int? isBookMarked,
  }) = _MemoDTO;

  factory MemoDTO.fromJson(MAP json) => _$MemoDTOFromJson(json);

  @override
  MAP toJson() => _$MemoDTOToJson(this);
}
