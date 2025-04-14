import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageCompressionUtil {
  static const int _maxWidth = 1080;
  static const int _maxHeight = 1920;
  static const int _quality = 85;

  /// 이미지 압축 및 리사이징
  static Future<File> compressAndResizeImage(File file) async {
    try {
      // 파일 확장자 확인
      final extension = path.extension(file.path).toLowerCase();

      // 임시 디렉토리 경로 가져오기
      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}$extension';

      // 이미지 형식에 따른 압축 설정
      CompressFormat format;
      switch (extension) {
        case '.png':
          format = CompressFormat.png;
          break;
        case '.webp':
          format = CompressFormat.webp;
          break;
        case '.heic':
        case '.heif':
          format = CompressFormat.heic;
          break;
        default:
          format = CompressFormat.jpeg; // 기본값
      }

      // 이미지 압축 및 리사이징
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: _quality,
        minWidth: _maxWidth,
        minHeight: _maxHeight,
        format: format,
      );

      if (result == null) {
        throw Exception('이미지 압축 실패');
      }

      return File(result.path);
    } catch (e) {
      print('이미지 압축 중 오류 발생: $e');
      rethrow;
    }
  }
}
