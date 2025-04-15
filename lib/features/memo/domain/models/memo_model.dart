part of 'model.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class MemoModel with _$MemoModel {
  const factory MemoModel({
    @JsonKey(name: 'memoId')
    int? memoId, // SQLite 자동 증가 ID // ✅ Firestore의 'id' 필드와 매핑
    @JsonKey(ignore: true) String? docId, // Firestore 문서 ID (가져오는 것만 진행)
    @JsonKey(ignore: true) UserModel? user,
    String? profileImageUrl,
    String? userId,
    String? userName,
    String? content,
    List<ImageModel>? images,
    List<LinkModel>? links,
    List<TagModel>? tags,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastViewedAt,
    @Default(false) bool isLocalMemo,
    @Default(false) bool isBookMarked,
  }) = _MemoModel;

  factory MemoModel.fromJson(MAP json) => _$MemoModelFromJson(json);
  @override
  MAP toJson() => _$MemoModelToJson(this);
}
