import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/domain/mappers/image_mapper.dart';
import 'package:verymemo/features/memo/domain/mappers/link_mapper.dart';
import 'package:verymemo/features/memo/domain/mappers/memo_mapper.dart';
import 'package:verymemo/features/memo/domain/mappers/tag_mapper.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
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
      'images': ImageMapper.toDTO(memo.imageUrls),
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
  Future<int> deleteMemo(int memoId) async {
    try {
      return await localDataSource.deleteMemo(memoId);
    } catch (e) {
      log("❌ Error deleting memo: $e");
      return 0; // 🔄 에러 발생 시 0 반환
    }
  }
}
