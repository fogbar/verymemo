import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_remote_data_source.dart';
import 'package:verymemo/features/memo/domain/mappers/mapper.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';

class MemoRepositoryImpl implements MemoRepository {
  final MemoLocalDataSource localDataSource;
  final MemoRemoteDataSource remoteDataSource;

  MemoRepositoryImpl(this.localDataSource, this.remoteDataSource);

  Map<String, dynamic> _mapToDTOs(MemoModel memo) {
    return {
      'dto': MemoMapper.toDTO(memo),
      'images': ImageMapper.toDTO(memo.images),
      'links': LinkMapper.toDTO(memo.links),
      'tags': TagMapper.toDTO(memo.tags),
    };
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
      // final localMemos = await localDataSource.getAllMemos();
      // return localMemos?.isNotEmpty == true ? localMemos : [];

      // == 동기화 클릭한 유저는 remote 에서 가져오도록 한다 ==
      final remoteMemos = await remoteDataSource.getAllMemos();
      print("remoteMemos: ${remoteMemos}");
      return remoteMemos?.isNotEmpty == true ? remoteMemos : [];
    } catch (e) {
      log("❌ Error fetching all memos: $e");
      return [];
    }
  }

  @override
  Future<void> addMemo(MemoModel memo) async {
    try {
      // 로컬 저장
      final localData = _mapToDTOs(memo);

      // 로컬 db에 저장되는 메모의 고유 id 값
      // ✅ localMemoId가 null일 경우 예외 처리
      final localMemoId = await localDataSource.addMemo(
        dto: localData['dto'],
        images: localData['images'],
        links: localData['links'],
        tags: localData['tags'],
      );

      if (localMemoId == null) throw Exception("로컬 저장 실패");

      print("addMemo: localMemoId ${localMemoId}");

      // == 동기화 클릭한 유저만 진행 ==
      // FireStore 저장
      await remoteDataSource.addMemo(memo, localMemoId);

      // == 동기화 클릭한 유저만 진행 ==
    } catch (e) {
      log("❌ Error adding memo: $e");
      rethrow; // 🔄 에러를 다시 던져서 상위에서 처리할 수 있게
    }
  }

  @override
  Future<int> updateMemo(MemoModel memo) async {
    try {
      final mappedData = _mapToDTOs(memo);

      final updatedLocalMemoId = await localDataSource.updateMemo(
        dto: mappedData['dto'],
        images: mappedData['images'],
        links: mappedData['links'],
        tags: mappedData['tags'],
      );

      final docId = memo.docId ?? '없는 경우 예외 처리 필요.';
      print("updateMemo docId: ${docId}");
      // == 동기화 클릭한 유저는 remote 에서 가져오도록 한다 ==
      await remoteDataSource.updateMemo(docId, memo);

      return updatedLocalMemoId;
    } catch (e) {
      log("❌ Error updating memo: $e");
      return 0; // 🔄 에러 발생 시 0 반환
    }
  }

  // FireStore 삭제 대응시에는 memoIds가 아니라 List<MemoModel> 을 받아서
  // 내부적으로 처리하는게 나을 것으로 보임.
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

  @override
  Future<List<MemoModel>?> searchMemos(String query) async {
    return await localDataSource.searchMemos(query);
  }
}
