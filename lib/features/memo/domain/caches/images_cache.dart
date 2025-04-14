import 'dart:developer';
import 'dart:io';

class ImagesCache {
  ImagesCache._();
  static final Map<String, List<File>> _tempImages = {};
  static final int _maxCacheSize = 10; // 최대 캐시 크기

  static void addTempImage(String userId, File image) {
    _tempImages[userId] ??= [];

    // 캐시 크기 제한
    if (_tempImages[userId]!.length >= _maxCacheSize) {
      // 가장 오래된 이미지 삭제
      final oldestImage = _tempImages[userId]!.removeAt(0);
      try {
        oldestImage.delete();
      } catch (e) {
        log('임시 이미지 삭제 실패: $e');
      }
    }

    _tempImages[userId]!.add(image);
  }

  static List<File>? getTempImages(String userId) {
    return _tempImages[userId];
  }

  static void clearTempImages(String userId) {
    try {
      _tempImages[userId]?.forEach((file) async {
        try {
          await file.delete();
        } catch (e) {
          log('임시 이미지 삭제 실패: $e');
        }
      });
      _tempImages.remove(userId);
    } catch (e) {
      log('임시 이미지 캐시 정리 실패: $e');
    }
  }
}
