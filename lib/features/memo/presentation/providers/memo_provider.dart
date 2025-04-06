import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';
import 'package:verymemo/features/memo/domain/caches/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_sort_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, MemoState>((ref) {
  final memoRepository = ref.watch(memoRepositoryProvider);
  final sortType = ref.watch(memoSortProvider);
  return MemoNotifier(memoRepository, sortType);
});

class MemoNotifier extends StateNotifier<MemoState> {
  final MemoRepository memoRepository;
  final MemoSortType sortType;
  MemoNotifier(this.memoRepository, this.sortType)
      : super(const MemoState.initial()) {
    _initialize();
  }

  /// [초기 데터 로드]
  Future<void> _initialize() async {
    await getAllMemos();
    // await deleteMemo([20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]);
  }

  /// [모든 메모 가져오기] : 초기에 한 번 모든 메모를 로드한다
  Future<void> getAllMemos() async {
    state = const MemoState.loading();
    try {
      final memoModels = await memoRepository.getAllMemos();
      final memos = memoModels?.whereType<MemoModel>().toList() ?? [];

      // 정렬 적용
      final sortedMemos = _sortMemos(memos);

      log("---> memos: $memos");
      MemoCache().addMemos(sortedMemos);
      state = MemoState.successed(sortedMemos);
    } catch (e) {
      log("❌ Error fetching memos: $e");
      state = MemoState.error('메모를 불러오지 못했습니다.');
    }
  }

  /// [메모 정렬]
  List<MemoModel> _sortMemos(List<MemoModel> memos) {
    switch (sortType) {
      case MemoSortType.lastViewed:
        memos.sort((a, b) => b.lastViewedAt!.compareTo(a.lastViewedAt!));
        break;
      case MemoSortType.latest:
        memos.sort((a, b) {
          final aDate = a.updatedAt ?? a.createdAt;
          final bDate = b.updatedAt ?? b.createdAt;
          return bDate.compareTo(aDate);
        });
        break;
      case MemoSortType.oldest:
        memos.sort((a, b) {
          final aDate = a.updatedAt ?? a.createdAt;
          final bDate = b.updatedAt ?? b.createdAt;
          return aDate.compareTo(bDate);
        });
        break;
    }
    return memos;
  }

  /// [특정 메모 가져오기]
  Future<MemoModel?> getMemo(int memoId) async {
    try {
      // 1️⃣ 캐시 조회
      final cachedMemo = MemoCache().getMemoById(memoId);
      if (cachedMemo != null) return cachedMemo;

      // 2️⃣ 서버 조회
      final memo = await memoRepository.getMemoById(memoId);
      if (memo != null) {
        MemoCache().updateMemo(memo); // 캐시에 저장
      }
      return memo;
    } catch (e) {
      log("❌ 특정 메모 불러오기 오류: $e");
      return null;
    }
  }

  // /// 🔄 [특정 메모 가져오기] : 캐시에서 먼저 조회
  // MemoModel? getMemoFromCache(int memoId) {
  //   return MemoCache().getMemoById(memoId); // 🔄 메모리 캐시에서 가져오기
  // }

  /// [메모 추가]
  Future<void> addMemo(MemoModel memo) async {
    try {
      state = const MemoState.loading();
      await memoRepository.addMemo(memo);

      // 메모 추가 후 전체 메모 다시 로드
      final memoModels = await memoRepository.getAllMemos();
      final memos = memoModels?.whereType<MemoModel>().toList() ?? [];

      // 작성일 기준 내림차순 정렬 (최신순)
      memos.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // 캐시 업데이트
      MemoCache().clearCache(); // 캐시 초기화
      MemoCache().addMemos(memos);

      state = MemoState.successed(memos);
    } catch (e) {
      log("❌ Error adding memo: $e");
      state = MemoState.error("메모를 추가하지 못했습니다.");
      rethrow;
    }
  }

  /// [Update Memo]
  Future<void> updateMemo(MemoModel memo) async {
    try {
      log("---> MemoNotifier.updateMemo 시작");
      log("---> 업데이트할 메모 ID: ${memo.memoId}");
      log("---> 업데이트할 메모 내용: ${memo.content}");

      // 메모 ID 검증
      if (memo.memoId == null) {
        log("---> 메모 ID가 null입니다!");
        throw Exception("메모 ID가 존재하지 않습니다.");
      }

      // 1. DB 업데이트
      log("---> DB 업데이트 시작");
      final result = await memoRepository.updateMemo(memo);
      log("---> DB 업데이트 결과: $result");

      if (result <= 0) {
        log("---> DB 업데이트 실패");
        throw Exception('메모 업데이트에 실패했습니다.');
      }
      log("---> DB 업데이트 성공");

      // 2. 현재 상태에서 메모 업데이트
      state.maybeWhen(
        successed: (memos) {
          final updatedMemos =
              memos.map((m) => m.memoId == memo.memoId ? memo : m).toList();

          // 정렬 적용
          final sortedMemos = _sortMemos(updatedMemos);

          // 상태 즉시 업데이트
          state = MemoState.successed(sortedMemos);
        },
        orElse: () {
          // 상태가 successed가 아닌 경우 전체 메모 다시 로드
          getAllMemos();
        },
      );

      log("---> MemoNotifier.updateMemo 완료");
    } catch (e, stackTrace) {
      log("---> 메모 업데이트 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      rethrow;
    }
  }

  /// [메모 삭제]
  /// 단일삭제: ref.read(memoProvider.notifier).deleteMemo(memoId);
  /// 다중삭제: ref.read(memoProvider.notifier).deleteMemo([memoId1, memoId2, memoId3]);
  Future<void> deleteMemo(dynamic memoIds) async {
    state = const MemoState.loading();
    try {
      final List<int> idsToDelete =
          memoIds is int ? [memoIds] : memoIds as List<int>;

      await memoRepository.deleteMemo(idsToDelete); // DB에서 삭제
      for (int memoId in idsToDelete) {
        MemoCache().deleteMemo(memoId); // 캐시에서 삭제
      }

      log("🗑 메모 삭제됨: ${idsToDelete.length}개 (${idsToDelete.join(', ')})");

      await getAllMemos(); // 🔄 목록 갱신
    } catch (e) {
      log("❌ 메모 삭제 오류: $e");
      state = MemoState.error("메모를 삭제하지 못했습니다.");
    }
  }

  /// 🔄 [링크 추출]
  List<LinkModel> extractLinks() {
    return state.maybeWhen(
      successed: (memos) => memos
          .where((memo) => memo.links != null && memo.links!.isNotEmpty)
          .expand((memo) => memo.links!)
          .toList(),
      orElse: () => [],
    );
  }

  /// 🔄 [이미지 추출]
  List<MemoModel> extractImages() {
    return state.maybeWhen(
      successed: (memos) => memos
          .where((memo) => memo.images != null && memo.images!.isNotEmpty)
          .toList(),
      orElse: () => [],
    );
  }

  /// [메모 검색]
  Future<void> searchMemos(String query) async {
    if (query.isEmpty) {
      await getAllMemos();
      return;
    }

    state = const MemoState.loading();
    try {
      final searchResults = await memoRepository.searchMemos(query);
      if (searchResults != null) {
        // 검색 결과도 정렬 적용
        final sortedResults = _sortMemos(searchResults);
        state = MemoState.successed(sortedResults);
      } else {
        state = const MemoState.successed([]);
      }
    } catch (e) {
      log("❌ Error searching memos: $e");
      state = MemoState.error('검색 중 오류가 발생했습니다.');
    }
  }
}
