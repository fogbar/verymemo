part of 'mapper.dart';

class TagMapper {
  // 🔄 Model → DTO 변환
  static List<TagDTO> toDTO(List<TagModel>? models) {
    if (models == null) return [];
    return models.map((e) => TagDTO(tagName: e.tagName)).toList();
  }

  // 🔄 DTO → Model 변환
  static List<TagModel> toModel(List<TagDTO>? dtos) {
    if (dtos == null) return [];
    return dtos.map((e) => TagModel(tagName: e.tagName)).toList();
  }

  // 🔄 JSON → DTO 변환
  static List<TagDTO> fromJson(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      final decoded = jsonDecode(json) as List<dynamic>;
      return decoded
          .map((e) => TagDTO.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("❌ Error parsing JSON to TagDTO: $e");
      return [];
    }
  }

  // 🔄 DTO → JSON 변환
  static String toJson(List<TagDTO>? dtos) {
    if (dtos == null) return '[]';
    return jsonEncode(dtos.map((e) => e.toJson()).toList());
  }
}
