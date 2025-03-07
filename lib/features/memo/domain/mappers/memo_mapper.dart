// import 'package:verymemo/features/memo/domain/models/entities/memo_entity.dart';
// import 'package:verymemo/features/memo/domain/models/memo_model.dart';

import 'package:verymemo/features/memo/domain/dtos/image_dto.dart';
import 'package:verymemo/features/memo/domain/dtos/link_dto.dart';
import 'package:verymemo/features/memo/domain/dtos/memo_dto.dart';
import 'package:verymemo/features/memo/domain/dtos/tag_dto.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';
import 'package:verymemo/features/memo/domain/models/link_model.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/domain/models/tag_model.dart';

class MemoMapper {
  // 🔄 Model → DTO 변환
  static MemoDTO toDTO(MemoModel model) {
    return MemoDTO(
      userId: model.user?.id ?? model.userId ?? "default_user_id",
      content: model.content,
      // images:
      //     model.imageUrls?.map((e) => ImageDTO(imageUrl: e?.imageUrl)).toList(),
      // links: model.links?.map((e) => LinkDTO(url: e?.linkUrl)).toList(),
      // tags: model.tags?.map((e) => TagDTO(tagName: e?.tagName)).toList(),
      createdAt: model.createdAt.toIso8601String(),
      updatedAt: model.updatedAt?.toIso8601String(),
      isLocalMemo: model.isLocalMemo,
    );
  }

  // 🔄 DTO → Model 변환
  static MemoModel toModel(
    MemoDTO dto, {
    List<ImageDTO> images = const [],
    List<LinkDTO> links = const [],
    List<TagDTO> tags = const [],
  }) {
    return MemoModel(
      memoId: dto.id,
      userId: dto.userId,
      content: dto.content ?? "",
      imageUrls:
          // dto.images?.map((e) => ImageModel(imageUrl: e.imageUrl)).toList(),
          images
              .map((img) => ImageModel(
                  imageUrl: img.imageUrl, description: img.description ?? ""))
              .toList(),
      // links: dto.links?.map((e) => LinkModel(linkUrl: e.url)).toList(),
      links: links
          .map((lnk) => LinkModel(linkUrl: lnk.url, metaTitle: lnk.metaTitle))
          .toList(),
      // tags: dto.tags?.map((e) => TagModel(tagName: e.tagName)).toList(),
      tags: tags.map((tag) => TagModel(tagName: tag.tagName)).toList(),
      createdAt:
          DateTime.parse(dto.createdAt ?? DateTime.now().toIso8601String()),
      updatedAt: dto.updatedAt != null ? DateTime.parse(dto.updatedAt!) : null,
      isLocalMemo: dto.isLocalMemo ?? 1,
    );
  }
}
