part of 'mapper.dart';

class ImageMapper {
  // 🔄 Model → DTO 변환
  static List<ImageDTO> toDTO(List<ImageModel>? models) {
    if (models == null || models.isEmpty) return [];
    return models
        .map((e) =>
            ImageDTO(imageUrl: e.imageUrl ?? "", description: e.description))
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

  /// [이미지 업로드 준비]
  static Future<List<ImageModel>> prepareImageModelsForMemo(
      List<File> files, String userId) async {
    final List<ImageModel> result = [];

    try {
      for (final file in files) {
        // 이미지 크기 체크
        if (await file.length() > 10 * 1024 * 1024) {
          throw Exception('이미지 크기가 너무 큽니다. (최대 10MB)');
        }

        // 이미지 압축 및 리사이징
        final compressedFile =
            await ImageCompressionUtil.compressAndResizeImage(file);

        // 압축된 이미지 업로드
        final url = await uploadImageToFirebase(compressedFile, userId);

        result.add(ImageModel(
          imageUrl: url,
          description: 'firebase_storage',
        ));

        // 임시 파일 정리
        await compressedFile.delete();
      }
      return result;
    } catch (e) {
      log('이미지 업로드 실패: $e');
      // 실패한 이미지 정리
      for (final file in files) {
        try {
          await file.delete();
        } catch (e) {
          log('임시 파일 삭제 실패: $e');
        }
      }
      rethrow;
    }
  }
}
