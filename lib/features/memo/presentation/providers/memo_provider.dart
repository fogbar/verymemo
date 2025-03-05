import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';

class MemoNotifier extends StateNotifier<MemoState> {
  final MemoRepository memoRepository;
  MemoNotifier(this.memoRepository) : super(const MemoState.initial()) {
    getAllMemos();
  }

  /// [모든 메모 가져오기] : 초기에 한 번 모든 메모를 로드한다
  Future<void> getAllMemos() async {
    state = const MemoState.loading();
    try {
      final memos = await memoRepository.getAllMemos();
      state = MemoState.loaded(
          memos.whereType<MemoModel>().map((memo) => memo.toJson()).toList());
    } catch (e) {
      state = MemoState.error('메모를 불러오지 못했습니다.');
    }
  }

  /// [특정 메모 가져오기]
  Future<MemoModel?> getMemo(int memoId) async {
    try {
      return await memoRepository.getMemo(memoId);
    } catch (e) {
      log("'❌ Error fetching memo: $e'");
      return null;
    }
  }

  /// [메모 추가]
  Future<void> addMemo(MemoModel memo) async {
    state = const MemoState.loading();
    try {
      await memoRepository.addMemo(memo.toJson());
      state = const MemoState.added();
      await getAllMemos(); // 목록 갱신
    } catch (e) {
      state = MemoState.error("메모를 추가하지 못했습니다.");
    }
  }

  /// [메모 업데이트]
  Future<void> updateMemo(int memoId, MemoModel memo) async {
    state = const MemoState.loading();
    try {
      await memoRepository.updateMemo(memoId, memo.toJson());
      state = const MemoState.updated();
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
      state = const MemoState.deleted();
      await getAllMemos();
    } catch (e) {
      state = MemoState.error('메모를 삭제하지 못했습니다.');
    }
  }
}
