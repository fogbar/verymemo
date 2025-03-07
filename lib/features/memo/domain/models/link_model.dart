import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'link_model.freezed.dart';
part 'link_model.g.dart';

@Freezed(fromJson: false)
@JsonSerializable()
class LinkModel with _$LinkModel {
  const factory LinkModel({
    int? linkId,
    @Default("") String? linkUrl,
    @Default("") String? thumbnail,
    @Default("") String? metaTitle,
    @Default("") String? metaDescription,
  }) = _LinkModel;

  factory LinkModel.fromJson(MAP json) => _$LinkModelFromJson(json);
  @override
  MAP toJson() => _$LinkModelToJson(this);
}
