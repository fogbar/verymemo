part of 'mapper.dart';

class MemoMapper {
  // 🔄 Model → DTO 변환
  static MemoDTO toDTO(MemoModel model) {
    return MemoDTO(
      userId: model.user?.id ?? model.userId ?? "",
      content: model.content,
      createdAt: model.createdAt.toIso8601String(),
      updatedAt: model.updatedAt?.toIso8601String(),
      isLocalMemo: model.isLocalMemo ? 1 : 0,
      isBookMarked: model.isBookMarked ? 1 : 0,
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
      images: images
          .map((img) => ImageModel(
              imageUrl: img.imageUrl, description: img.description ?? ""))
          .toList(),
      links: links
          .map((lnk) =>
              LinkModel(linkUrl: lnk.linkUrl, metaTitle: lnk.metaTitle))
          .toList(),
      tags: tags.map((tag) => TagModel(tagName: tag.tagName)).toList(),
      createdAt:
          DateTime.parse(dto.createdAt ?? DateTime.now().toIso8601String()),
      updatedAt: dto.updatedAt != null ? DateTime.parse(dto.updatedAt!) : null,
      isLocalMemo: dto.isLocalMemo == 1,
    );
  }
}
