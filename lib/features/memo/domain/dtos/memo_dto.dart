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
    String? lastViewedAt,
    // @Default([]) List<ImageDTO>? images, // 💡 images 테이블과 연결
    // @Default([]) List<LinkDTO>? links, // 💡 links 테이블과 연결
    // @Default([]) List<TagDTO>? tags, // 💡 tags 테이블과 연결 (N:M 관계)
    int? isLocalMemo, // 💡 0 또는 1
    int? isBookMarked,
  }) = _MemoDTO;

  factory MemoDTO.fromJson(MAP json) => _$MemoDTOFromJson(json);
  factory MemoDTO.fromJson2(Map<String, dynamic> json) {
    return MemoDTO(
      id: json['id'] as int?,
      userId: json['userId']?.toString(), // 🔄 userId를 String으로 변환
      content: json['content'] as String?,
      createdAt: _convertToString(json['createdAt']), // 🔄 createdAt 변환 추가
      updatedAt: _convertToString(json['updatedAt']),
      lastViewedAt: _convertToString(json['lastViewedAt']),
      isLocalMemo: json['isLocalMemo'] as int?,
      isBookMarked: json['isBookMarked'] as int?,
    );
  }

  // 🔄 createdAt, updatedAt을 안전하게 변환하는 메서드 추가
  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value).toIso8601String();
    }
    if (value is String) return value;
    return null;
  }

  @override
  MAP toJson() => _$MemoDTOToJson(this);
}
