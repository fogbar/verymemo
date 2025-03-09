part of 'model.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class MemoModel with _$MemoModel {
  const factory MemoModel({
    int? memoId,
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
    @Default(false) bool isLocalMemo,
    @Default(false) bool isBookMarked,
  }) = _MemoModel;

  factory MemoModel.fromJson(MAP json) => _$MemoModelFromJson(json);
  @override
  MAP toJson() => _$MemoModelToJson(this);
}
