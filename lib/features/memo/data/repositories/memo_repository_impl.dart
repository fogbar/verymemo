import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/features/auth/domain/models/user_model.dart';
import 'package:verymemo/features/auth/presentation/providers/auth_provider.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_remote_data_source.dart';
import 'package:verymemo/features/memo/domain/mappers/mapper.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';

class MemoRepositoryImpl implements MemoRepository {
  final Ref ref;
  final MemoLocalDataSource localDataSource;
  final MemoRemoteDataSource remoteDataSource;

  MemoRepositoryImpl(this.ref, this.localDataSource, this.remoteDataSource);

  /// 현재 로그인된 유저를 반환하고, 없으면 예외를 던진다.
  /// 활용 예시: final user = requireCurrentUser(ref);
  UserModel _getCurrentUser() {
    final user = ref.read(authStateNotifierProvider).maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
    if (user == null) throw Exception('로그인이 필요합니다');
    return user;
  }

  String _getCurrentUserId() {
    final currentUser = _getCurrentUser();
    return currentUser.uid; // uid임. 명심.
  }

  // 유저가 메모 crud시 firestore에 바로 동기화 되야하는지 안되도 되는지 판단하는 로직
  bool isFirestoreSync() {
    final currentUser = _getCurrentUser();
    return (currentUser.isSynced ?? false) &&
        currentUser.syncType == UserSyncType.firestore;
  }

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
      final userId = _getCurrentUserId();
      if (isFirestoreSync()) {
        // == 동기화 클릭한 유저는 remote 에서 가져오도록 한다 ==
        final remoteMemos = await remoteDataSource.getAllMemos(userId);
        print("remoteMemos: ${remoteMemos}");
        return remoteMemos?.isNotEmpty == true ? remoteMemos : [];
      } else {
        final localMemos = await localDataSource.getAllMemos(userId);
        return localMemos?.isNotEmpty == true ? localMemos : [];
      }
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
      if (isFirestoreSync()) {
        // FireStore 저장
        final remoteMemoDocId =
            await remoteDataSource.addMemo(memo, localMemoId);

        // 🔥 로컬 DB에 Firestore docId 매핑
        await localDataSource.bulkUpdateDocIds({localMemoId: remoteMemoDocId});
      }
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

      // == 동기화 클릭한 유저만 진행 ==
      if (isFirestoreSync()) {
        final docId = memo.docId!;
        print("updateMemo docId: ${docId}");
        // == 동기화 클릭한 유저는 remote 에서 가져오도록 한다 ==
        await remoteDataSource.updateMemo(docId, memo);
      }

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
      // return await remoteDataSource.deleteMemos(docIds);
    } catch (e) {
      log("❌ Error deleting memo: $e");
      return 0; // 🔄 에러 발생 시 0 반환
    }
  }

  /// 해당 이미지 구현 의도를 모르겠습니다.
  /// 애초에 불필요한 이미지는 저장이 되면 안되는데, 굳이 저장한 이유는 무엇이며,
  /// 이렇게 앱 실행시마다 초기화하는 이유는 무엇일까요?
  /// 혹시 production이 아닌 개발 시에만 처리되도록 하는 것이 의도였을까요?
  /// 만약 그렇다면 main 부분에서 제대로 처리가 필요해보입니다.
  /// 해당 함수 관련하여 보시는대로 설명 요청드립니다 :)
  ///
  /// main 에서 실행하게 될 경우 userId 값을 못가져오므로 우선 FireStore 관련 개발 먼저 마무리 후
  /// 추가하더라도 향후 추가하는 쪽으로 가면 좋을 것 같습니다. 로컬에서만 필요해보여서요.
  @override
  Future<void> cleanupUnusedImages() async {
    // try {
    //   final memos = await getAllMemos(userId);
    //   final usedImages = <String>{};

    //   for (var memo in memos ?? []) {
    //     for (var image in memo.images) {
    //       if (image.imageUrl != null &&
    //           image.description == 'internal_storage') {
    //         usedImages.add(image.imageUrl!);
    //       }
    //     }
    //   }

    //   final appDir = await getApplicationDocumentsDirectory();
    //   final imageDir = Directory('${appDir.path}/memo_images');

    //   if (await imageDir.exists()) {
    //     await for (var entity in imageDir.list()) {
    //       if (entity is File && !usedImages.contains(entity.path)) {
    //         await entity.delete();
    //       }
    //     }
    //   }
    // } catch (e) {
    //   log("❌ Error cleaning up images: $e");
    // }
  }

  @override
  Future<List<MemoModel>?> searchMemos(String query) async {
    return await localDataSource.searchMemos(query);
  }

  @override
  Future<void> syncMemoWithFireStore() async {
    // 동기화 성능 측정
    final stopwatch = Stopwatch()..start();
    try {
      final userId = _getCurrentUserId();

      final localMemos = await localDataSource.getAllMemos(userId);
      if (localMemos == null || localMemos.isEmpty) return;

      final existingMemos = localMemos.where((m) => m.docId != null).toList();
      final newMemos = localMemos.where((m) => m.docId == null).toList();

      // Firestore 배치 업데이트
      if (existingMemos.isNotEmpty) {
        await remoteDataSource.updateMemos(existingMemos);
      }

      // Firestore 배치 추가 및 로컬 docId 매핑
      if (newMemos.isNotEmpty) {
        final docIdMap = await remoteDataSource.addMemos(newMemos);
        await _bulkUpdateLocalDocIds(docIdMap);
      }

      // 유저가 FireStore와 동기화 되었다는 것을 알기 위해 컬럼 업데이트
      final authStateNotiProvider =
          ref.read(authStateNotifierProvider.notifier);

      authStateNotiProvider.updateUserIsSynced(
          isSynced: true, syncType: UserSyncType.firestore);

      // 🔥 추가된 부분: 유저 정보 강제 갱신
      await authStateNotiProvider.refreshUser();

      log("✅ 동기화 완료: ${existingMemos.length}개 업데이트, ${newMemos.length}개 추가");
    } catch (e, stackTrace) {
      log("❌ 동기화 실패: $e", error: e, stackTrace: stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
      print("동기화 완료 시간 : ${stopwatch.elapsed}");
      // Analytics().logSyncDuration(stopwatch.elapsed);
    }
  }

  // SQLite 벌크 업데이트 추가
  Future<void> _bulkUpdateLocalDocIds(Map<int, String> docIdMap) async {
    await localDataSource.bulkUpdateDocIds(docIdMap);
  }
}
