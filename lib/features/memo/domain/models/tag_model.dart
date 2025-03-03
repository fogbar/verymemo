import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required String tagName,
  }) = _TagModel;

  factory TagModel.fromJson(MAP json) => _$TagModelFromJson(json);
}
