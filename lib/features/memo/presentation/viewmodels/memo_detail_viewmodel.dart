import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';
import 'package:flutter/services.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';

final memoDetailProvider =
    StateNotifierProvider<MemoDetailViewModel, void>((ref) {
  return MemoDetailViewModel(ref);
});

final bookmarkStateProvider = StateProvider<bool>((ref) => false);

class MemoDetailViewModel extends StateNotifier<MemoState> {
  MemoDetailViewModel(this._ref) : super(const MemoState.initial());

  final Ref _ref;

  void handleDelete(String id) {
    debugPrint('메모 삭제 요청: $id');
    // TODO: 삭제 로직 구현
  }

  void handleShare(String id) {
    debugPrint('공유 요청: $id');
    // TODO: 공유 로직 구현
  }

  void handleCopy(String id, BuildContext context) async {
    final memoState = _ref.read(memoProvider);

    final memo = memoState.whenOrNull(
      successed: (memos) {
        final memoIdInt = int.tryParse(id);
        return memos.where((m) => m.memoId == memoIdInt).firstOrNull;
      },
    );

    if (memo?.content != null) {
      await Clipboard.setData(ClipboardData(text: memo!.content!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('복사되었습니다'),
          duration: Duration(seconds: 1),
        ),
      );
      debugPrint('메모 복사됨: ${memo.content}');
    }
  }

  /// 북마크 토글
  Future<void> handleBookmark(String id) async {
    try {
      log("---> 북마크 토글 시작");
      final memoState = _ref.read(memoProvider);

      final memo = memoState.whenOrNull(
        successed: (memos) {
          final memoIdInt = int.tryParse(id);
          return memos.where((m) => m.memoId == memoIdInt).firstOrNull;
        },
      );

      if (memo != null) {
        log("---> 현재 북마크 상태: ${memo.isBookMarked}");
        final updatedMemo = memo.copyWith(
          isBookMarked: !memo.isBookMarked,
        );
        log("---> 업데이트된 북마크 상태: ${updatedMemo.isBookMarked}");

        await _ref.read(memoProvider.notifier).updateMemo(updatedMemo);
        _ref.read(bookmarkStateProvider.notifier).state =
            updatedMemo.isBookMarked;
        log("---> 북마크 업데이트 완료");
      }
    } catch (e, stackTrace) {
      log("---> 북마크 토글 실패: $e");
      log("---> 스택트레이스: $stackTrace");
    }
  }

  void handleUpload(String id) {
    // TODO: 메모 업로드/공유 기능 구현
    debugPrint('메모 업로드: $id');
  }

  void handleEdit(String id, BuildContext context) {
    final memoState = _ref.read(memoProvider);
    memoState.maybeWhen(
      successed: (memos) {
        final memoIdInt = int.tryParse(id);
        if (memoIdInt != null) {
          final memo = memos.firstWhere((m) => m.memoId == memoIdInt);
          context.push('/edit', extra: memo);
        }
      },
      orElse: () {},
    );
  }
}
