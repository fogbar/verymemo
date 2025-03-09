part of 'model.dart';

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    String? tagName,
  }) = _TagModel;

  factory TagModel.fromJson(MAP json) => _$TagModelFromJson(json);
}
