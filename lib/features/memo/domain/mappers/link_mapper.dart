part of 'mapper.dart';

class LinkMapper {
  // 🔄 Model → DTO 변환
  static List<LinkDTO> toDTO(List<LinkModel>? models) {
    if (models == null) return [];
    return models
        .map((e) => LinkDTO(
              linkUrl: e.linkUrl ?? '',
              thumbnail: e.thumbnail ?? '',
              metaTitle: e.metaTitle ?? '',
              metaDescription: e.metaDescription ?? '',
            ))
        .toList();
  }

  // 🔄 DTO → Model 변환
  static List<LinkModel> toModel(List<LinkDTO>? dtos) {
    if (dtos == null) return [];
    return dtos
        .map((e) => LinkModel(
              linkId: e.id,
              linkUrl: e.linkUrl,
              thumbnail: e.thumbnail ?? '',
              metaTitle: e.metaTitle ?? '',
              metaDescription: e.metaDescription ?? '',
            ))
        .toList();
  }

  // 🔄 JSON → DTO 변환
  static List<LinkDTO> fromJson(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      final decoded = jsonDecode(json) as List<dynamic>;
      return decoded
          .map((e) => LinkDTO.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("❌ Error parsing JSON to LinkDTO: $e");
      return [];
    }
  }

  // 🔄 DTO → JSON 변환
  static String toJson(List<LinkDTO>? dtos) {
    if (dtos == null) return '[]';
    return jsonEncode(dtos.map((e) => e.toJson()).toList());
  }
}
