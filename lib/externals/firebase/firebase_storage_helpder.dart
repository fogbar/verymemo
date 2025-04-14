import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageHelper {
  FirebaseStorageHelper._();

  /// 이미지 업로드 및 진행률 모니터링
  static Future<UploadTask> uploadImageWithProgress(
    File file,
    String userId, {
    void Function(double progress)? onProgress,
  }) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${const Uuid().v4()}${path.extension(file.path)}';
    final ref = FirebaseStorage.instance.ref().child('users/$userId/$fileName');

    final extension = path.extension(file.path).toLowerCase();
    String contentType;

    switch (extension) {
      case '.jpg':
      case '.jpeg':
        contentType = 'image/jpeg';
        break;
      case '.png':
        contentType = 'image/png';
        break;
      case '.gif':
        contentType = 'image/gif';
        break;
      case '.webp':
        contentType = 'image/webp';
        break;
      case '.heic':
      case '.heif':
        contentType = 'image/heic';
        break;
      case '.svg':
        contentType = 'image/svg+xml';
        break;
      default:
        contentType = 'image/jpeg';
    }

    final uploadTask = ref.putFile(
      file,
      SettableMetadata(
        contentType: contentType,
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
          'originalFileName': path.basename(file.path),
          'fileExtension': extension,
        },
      ),
    );

    // 진행률 콜백이 제공된 경우 리스닝
    if (onProgress != null) {
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        onProgress(progress);
      });
    }

    return uploadTask;
  }

  /// 이미지 업로드 (간단한 버전)
  static Future<String> uploadImage(File file, String userId) async {
    final uploadTask = await uploadImageWithProgress(file, userId);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}

Future<String> uploadImageToFirebase(File file, String userId) async {
  try {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${const Uuid().v4()}${path.extension(file.path)}';
    final ref = FirebaseStorage.instance.ref().child('users/$userId/$fileName');

    // 파일 확장자에 따른 contentType 설정
    final extension = path.extension(file.path).toLowerCase();
    String contentType;

    switch (extension) {
      case '.jpg':
      case '.jpeg':
        contentType = 'image/jpeg';
        break;
      case '.png':
        contentType = 'image/png';
        break;
      case '.gif':
        contentType = 'image/gif';
        break;
      case '.webp':
        contentType = 'image/webp';
        break;
      case '.heic':
      case '.heif':
        contentType = 'image/heic';
        break;
      case '.svg':
        contentType = 'image/svg+xml';
        break;
      default:
        contentType = 'image/jpeg'; // 기본값
    }

    // 업로드 진행률 모니터링
    final uploadTask = ref.putFile(
      file,
      SettableMetadata(
        contentType: contentType,
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
          'originalFileName': path.basename(file.path),
          'fileExtension': extension,
        },
      ),
    );

    // 업로드 진행률 스트림 리스닝
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      print('Upload is ${progress.toStringAsFixed(2)}% complete');
    });

    // 업로드 완료 대기
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print('Firebase Storage 업로드 실패: $e');
    rethrow;
  }
}
