import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';

part 'link_data_model.freezed.dart';
part 'link_data_model.g.dart';

@freezed
class LinkDataModel with _$LinkDataModel {
  const factory LinkDataModel({
    required String url,
    @Default("") String thumbnail,
    @Default("") String metaTitle,
    @Default("") String metaDescription,
  }) = _LinkDataModel;

  factory LinkDataModel.fromJson(MAP json) => _$LinkDataModelFromJson(json);
}
