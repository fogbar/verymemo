import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';
import 'package:verymemo/features/memo/domain/caches/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, MemoState>((ref) {
  final memoRepository = ref.watch(memoRepositoryProvider);
  return MemoNotifier(memoRepository);
});

class MemoNotifier extends StateNotifier<MemoState> {
  final MemoRepository memoRepository;
  MemoNotifier(this.memoRepository) : super(const MemoState.initial()) {
    _initialize();
  }

  /// [초기 데터 로드]
  Future<void> _initialize() async {
    await getAllMemos();
  }

  /// [모든 메모 가져오기] : 초기에 한 번 모든 메모를 로드한다
  Future<void> getAllMemos() async {
    state = const MemoState.loading();
    try {
      final memoModels = await memoRepository.getAllMemos();
      log("---> 가져온 원본 메모: $memoModels");

      final memos = memoModels?.where((memo) {
            log("---> 메모 이미지: ${memo.images}");
            return memo != null;
          }).toList() ??
          [];

      // 작성일 기준 내림차순 정렬 (최신순)
      memos.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      MemoCache().addMemos(memos);
      state = MemoState.successed(memos);
    } catch (e, stack) {
      log("❌ Error fetching memos: $e");
      log("❌ Stack trace: $stack");
      state = MemoState.error('메모를 불러오지 못했습니다.');
    }
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
    state = const MemoState.loading();
    try {
      await memoRepository.addMemo(memo);
      await getAllMemos(); // 이미 getAllMemos에서 정렬을 수행하므로 새로운 메모가 맨 위에 표시됨
    } catch (e) {
      log("❌ Error adding memo: $e");
      state = MemoState.error("메모를 추가하지 못했습니다.");
    }
  }

  /// [메모 업데이트]
  Future<void> updateMemo(MemoModel memo) async {
    state = const MemoState.loading();
    try {
      await memoRepository.updateMemo(memo);
      MemoCache().updateMemo(memo);
      state = MemoState.successed(MemoCache().getAllMemos());
      await getAllMemos();
    } catch (e) {
      state = MemoState.error('메모를 업데이트하지 못했습니다.');
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
}
