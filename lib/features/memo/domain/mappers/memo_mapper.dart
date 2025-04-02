part of 'mapper.dart';

class MemoMapper {
  // 🔄 Model → DTO 변환
  static MemoDTO toDTO(MemoModel model) {
    log("---> MemoMapper.toDTO 호출");
    log("---> model.updatedAt: ${model.updatedAt}");

    final dto = MemoDTO(
      id: model.memoId,
      userId: model.user?.id ?? model.userId ?? "",
      content: model.content,
      createdAt: _dateTimeToString(model.createdAt),
      updatedAt: _dateTimeToString(model.updatedAt),
      lastViewedAt: _dateTimeToString(model.lastViewedAt),
      isLocalMemo: model.isLocalMemo ? 1 : 0,
      isBookMarked: model.isBookMarked ? 1 : 0,
    );

    log("---> 생성된 DTO의 updatedAt: ${dto.updatedAt}");
    return dto;
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
      userId: dto.userId?.toString(),
      content: dto.content ?? "",
      images: images
          .map((img) => ImageModel(
              imageUrl: img.imageUrl, description: img.description ?? ""))
          .toList(),
      links: links
          .map((lnk) => LinkModel(
                linkUrl: lnk.linkUrl,
                metaTitle: lnk.metaTitle,
                thumbnail: lnk.thumbnail,
                metaDescription: lnk.metaDescription,
              ))
          .toList(),
      tags: tags.map((tag) => TagModel(tagName: tag.tagName)).toList(),
      createdAt: _stringToDateTime(dto.createdAt),
      updatedAt: _stringToDateTime(dto.updatedAt),
      lastViewedAt: _stringToDateTime(dto.lastViewedAt),
      isLocalMemo: dto.isLocalMemo == 1,
      isBookMarked: dto.isBookMarked == 1,
    );
  }

  // 🔄 DateTime → String 변환 (ISO 8601 형식)
  static String? _dateTimeToString(DateTime? dateTime) {
    return dateTime?.toIso8601String();
  }

  // 🔄 String → DateTime 변환 (예외 처리 추가)
  static DateTime _stringToDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return DateTime.now(); // 기본값 설정
    }
    try {
      return DateTime.parse(dateTimeString);
    } catch (e) {
      return DateTime.now(); // 파싱 오류 시 현재 시간 반환
    }
  }
}
