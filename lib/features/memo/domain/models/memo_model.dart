import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';
import 'package:verymemo/features/memo/domain/models/link_model.dart';
import 'package:verymemo/features/memo/domain/models/tag_model.dart';

part 'memo_model.g.dart';
part 'memo_model.freezed.dart';

@Freezed(
    fromJson: false, toJson: true) // 🔄 `freezed`의 `fromJson`과 `toJson` 활성화
@JsonSerializable()
class MemoModel with _$MemoModel {
  const factory MemoModel({
    int? memoId,
    @JsonKey(ignore: true) UserModel? user,
    String? userId,
    @Default("") String content,
    @JsonKey(fromJson: _imageUrlsFromJson, toJson: _imageUrlsToJson)
    List<ImageModel>? imageUrls, // 💡 nullable 처리
    @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
    List<LinkModel>? links, // 💡 nullable 처리
    @JsonKey(fromJson: _tagsFromJson, toJson: _tagsToJson)
    List<TagModel>? tags, // 💡 nullable 처리
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(1) int isLocalMemo,
  }) = _MemoModel;

  // 🔄 `freezed`가 자동 생성하는 `fromJson` 사용
  factory MemoModel.fromJson(MAP json) => _$MemoModelFromJson(json);

  // 🔄 `freezed`가 자동 생성하는 `toJson` 사용
  MAP toJson() => _$MemoModelToJson(this);
}

// 🔄 커스텀 역직렬화 로직 (nullable 지원)
List<ImageModel> _imageUrlsFromJson(dynamic json) {
  if (json == null) return [];
  return (json as List)
      .map((e) => e == null ? null : ImageModel.fromJson(e))
      .whereType<ImageModel>() // 💡 null 제거
      .toList();
}

dynamic _imageUrlsToJson(List<ImageModel>? images) =>
    images?.map((e) => e.toJson()).toList() ?? [];

List<LinkModel> _linksFromJson(dynamic json) {
  if (json == null) return [];
  return (json as List)
      .map((e) => e == null ? null : LinkModel.fromJson(e))
      .whereType<LinkModel>() // 💡 null 제거
      .toList();
}

dynamic _linksToJson(List<LinkModel>? links) =>
    links?.map((e) => e.toJson()).toList() ?? [];

List<TagModel> _tagsFromJson(dynamic json) {
  if (json == null) return [];
  return (json as List)
      .map((e) => e == null ? null : TagModel.fromJson(e))
      .whereType<TagModel>() // 💡 null 제거
      .toList();
}

dynamic _tagsToJson(List<TagModel>? tags) =>
    tags?.map((e) => e.toJson()).toList() ?? [];
