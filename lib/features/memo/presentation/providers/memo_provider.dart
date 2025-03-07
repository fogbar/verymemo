import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';
import 'package:verymemo/features/memo/domain/cache/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';

final memoProvider = StateNotifierProvider<MemoNotifier, MemoState>((ref) {
  final memoRepository = ref.watch(memoRepositoryProvider);
  return MemoNotifier(memoRepository);
});

class MemoNotifier extends StateNotifier<MemoState> {
  final MemoRepository memoRepository;
  MemoNotifier(this.memoRepository) : super(const MemoState.initial()) {
    getAllMemos();
  }

  /// [모든 메모 가져오기] : 초기에 한 번 모든 메모를 로드한다
  Future<void> getAllMemos() async {
    // state = const MemoState.loading();
    try {
      final memoModels = await memoRepository.getAllMemos();
      final memos = memoModels?.whereType<MemoModel>().toList() ?? [];

      log("---> memos: $memos");
      MemoCache().addMemos(memos); // 🔄 캐시에 저장
      state = MemoState.successed(memos);
    } catch (e) {
      log("❌ Error fetching memos: $e");
      state = MemoState.error('메모를 불러오지 못했습니다.');
    }
  }

  /// [특정 메모 가져오기]
  Future<MemoModel?> getMemo(int memoId) async {
    try {
      // 🔄 캐시 우선 조회
      final cachedMemo = getMemoFromCache(memoId);
      if (cachedMemo != null) return cachedMemo;

      final memo = await memoRepository.getMemoById(memoId);
      if (memo != null) {
        MemoCache().updateMemo(memo); // 🔄 캐시에 저장
      }
      return memo;
    } catch (e) {
      log("❌ Error fetching memo: $e");
      return null;
    }
  }

  /// 🔄 [특정 메모 가져오기] : 캐시에서 먼저 조회
  MemoModel? getMemoFromCache(int memoId) {
    return MemoCache().getMemoById(memoId); // 🔄 메모리 캐시에서 가져오기
  }

  /// [메모 추가]
  Future<void> addMemo(MemoModel memo) async {
    state = const MemoState.loading();
    try {
      await memoRepository.addMemo(memo);
      MemoCache().addMemos([...MemoCache().getAllMemos(), memo]);
      log("---> 메모가 추가됐어요: ${memo.content}");
      await getAllMemos(); // 🔄 목록 갱신

      state = MemoState.successed(MemoCache().getAllMemos());
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
  Future<void> deleteMemo(int memoId) async {
    state = const MemoState.loading();
    try {
      await memoRepository.deleteMemo(memoId);
      MemoCache().deleteMemo(memoId);
      state = MemoState.successed(MemoCache().getAllMemos());
      await getAllMemos();
    } catch (e) {
      state = MemoState.error('메모를 삭제하지 못했습니다.');
    }
  }
}
