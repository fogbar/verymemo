import 'dart:convert';
import 'dart:developer';

import 'package:verymemo/features/memo/domain/dtos/image_dto.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';

class ImageMapper {
  // 🔄 Model → DTO 변환
  static List<ImageDTO> toDTO(List<ImageModel>? models) {
    if (models == null || models.isEmpty) return [];
    return models
        .map((e) => ImageDTO(imageUrl: e.imageUrl, description: e.description))
        .toList();
  }

  // 🔄 DTO → Model 변환
  static List<ImageModel> toModel(List<ImageDTO>? dtos) {
    if (dtos == null || dtos.isEmpty) return [];
    return dtos
        .map((e) => ImageModel(
            imageId: e.id,
            imageUrl: e.imageUrl,
            description: e.description ?? ""))
        .toList();
  }

  // 🔄 JSON → DTO 변환
  static List<ImageDTO> fromJson(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      return (jsonDecode(json) as List)
          .map((e) => ImageDTO.fromJson(e))
          .toList();
    } catch (e) {
      log("❌ JSON 파싱 오류: $e");
      return [];
    }
  }

  // 🔄 DTO → JSON 변환
  static String toJson(List<ImageDTO>? dtos) {
    if (dtos == null || dtos.isEmpty) return '[]';
    return jsonEncode(dtos.map((e) => e.toJson()).toList());
  }
}
