import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/domain/mappers/mapper.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';

final memoRepositoryProvider = Provider<MemoRepository>((ref) {
  final memoLocalDataSource = ref.watch(memoLocalDataSourceProvider);
  return MemoRepositoryImpl(memoLocalDataSource);
});

class MemoRepositoryImpl implements MemoRepository {
  final MemoLocalDataSource localDataSource;

  MemoRepositoryImpl(this.localDataSource);

  Map<String, dynamic> _mapToDTOs(MemoModel memo) {
    return {
      'dto': MemoMapper.toDTO(memo),
      'images': ImageMapper.toDTO(memo.images),
      'links': LinkMapper.toDTO(memo.links),
      'tags': TagMapper.toDTO(memo.tags),
    };
  }

  @override
  Future<void> addMemo(MemoModel memo) async {
    try {
      final mappedData = _mapToDTOs(memo);

      await localDataSource.addMemo(
        dto: mappedData['dto'],
        images: mappedData['images'],
        links: mappedData['links'],
        tags: mappedData['tags'],
      );
    } catch (e) {
      log("❌ Error adding memo: $e");
      rethrow; // 🔄 에러를 다시 던져서 상위에서 처리할 수 있게
    }
  }

  @override
  Future<MemoModel?> getMemoById(int memoId) async {
    try {
      final model = await localDataSource.getMemoById(memoId);
      if (model == null) return null;
      return model;
    } catch (e) {
      log("❌ Error fetching memo by ID: $e");
      return null;
    }
  }

  @override
  Future<List<MemoModel>?> getAllMemos() async {
    try {
      final memoModels = await localDataSource.getAllMemos();
      return memoModels?.isNotEmpty == true ? memoModels : [];
    } catch (e) {
      log("❌ Error fetching all memos: $e");
      return [];
    }
  }

  @override
  Future<int> updateMemo(MemoModel memo) async {
    try {
      final mappedData = _mapToDTOs(memo);

      return await localDataSource.updateMemo(
        dto: mappedData['dto'],
        images: mappedData['images'],
        links: mappedData['links'],
        tags: mappedData['tags'],
      );
    } catch (e) {
      log("❌ Error updating memo: $e");
      return 0; // 🔄 에러 발생 시 0 반환
    }
  }

  @override
  Future<int> deleteMemo(List<int> memoIds) async {
    try {
      return await localDataSource.deleteMemos(memoIds);
    } catch (e) {
      log("❌ Error deleting memo: $e");
      return 0; // 🔄 에러 발생 시 0 반환
    }
  }

  @override
  Future<void> cleanupUnusedImages() async {
    try {
      final memos = await getAllMemos();
      final usedImages = <String>{};

      for (var memo in memos ?? []) {
        for (var image in memo.images) {
          if (image.imageUrl != null &&
              image.description == 'internal_storage') {
            usedImages.add(image.imageUrl!);
          }
        }
      }

      final appDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory('${appDir.path}/memo_images');

      if (await imageDir.exists()) {
        await for (var entity in imageDir.list()) {
          if (entity is File && !usedImages.contains(entity.path)) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      log("❌ Error cleaning up images: $e");
    }
  }
}
