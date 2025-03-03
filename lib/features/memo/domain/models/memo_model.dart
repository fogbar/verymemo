import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';
import 'package:verymemo/features/memo/domain/models/link_data_model.dart';
import 'package:verymemo/features/memo/domain/models/tag_model.dart';

part 'memo_model.g.dart';
part 'memo_model.freezed.dart';

@freezed
class MemoModel with _$MemoModel {
  const factory MemoModel({
    UserModel? user,
    @Default("") String content,
    @Default([]) List<ImageModel> imageUrls,
    @Default([]) List<LinkDataModel> links,
    @Default([]) List<TagModel> tags,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isLocalMemo,
  }) = _MemoModel;

  factory MemoModel.fromJson(MAP json) => _$MemoModelFromJson(json);

  factory MemoModel.defaults() => MemoModel(
        createdAt: DateTime.now(),
      );
}
