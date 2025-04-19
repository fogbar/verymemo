import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_delete_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verymemo/features/auth/data/data-sources/firebase/firebase_service.dart';

final memoDetailProvider =
    StateNotifierProvider<MemoDetailViewModel, void>((ref) {
  return MemoDetailViewModel(ref);
});

final bookmarkStateProvider = StateProvider<bool>((ref) => false);

class MemoDetailViewModel extends StateNotifier<void> {
  MemoDetailViewModel(this._ref) : super(null);

  final Ref _ref;

  void handleDelete(String id, BuildContext context) {
    _ref.read(memoDeleteProvider).deleteMemo(context, int.tryParse(id));
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
  void handleBookmark(String id) {
    final memoState = _ref.read(memoProvider);
    memoState.whenOrNull(
      successed: (memos) {
        final memo = memos.firstWhere((m) => m.memoId.toString() == id);
        final updatedMemo = memo.copyWith(
          isBookMarked: !memo.isBookMarked,
        );
        _ref.read(memoProvider.notifier).updateMemo(updatedMemo);
      },
    );
  }

  Future<void> handleUpload(String id, BuildContext context) async {
    try {
      log("---> 메모 업로드 시작");
      final memoState = _ref.read(memoProvider);
      final firebaseService = _ref.read(firebaseServiceProvider);
      final currentUser = await firebaseService.getCurrentUser();

      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인이 필요합니다')),
        );
        return;
      }

      final memo = memoState.whenOrNull(
        successed: (memos) {
          final memoIdInt = int.tryParse(id);
          return memos.where((m) => m.memoId == memoIdInt).firstOrNull;
        },
      );

      if (memo != null) {
        final firestore = FirebaseFirestore.instance;
        final memoRef = firestore.collection('memos').doc();

        await memoRef.set({
          'id': memo.memoId,
          'content': memo.content,
          'userId': currentUser.uid,
          'userName': currentUser.displayName,
          'userPhotoUrl': currentUser.photoUrl,
          'createdAt': memo.createdAt.toIso8601String(),
          'updatedAt': memo.updatedAt?.toIso8601String(),
          'isBookMarked': memo.isBookMarked,
          'links': memo.links,
          'images': memo.images,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('메모가 공개되었습니다')),
        );
        log("---> 메모 업로드 완료");
      }
    } catch (e, stackTrace) {
      log("---> 메모 업로드 실패: $e");
      log("---> 스택트레이스: $stackTrace");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('메모 업로드에 실패했습니다')),
      );
    }
  }

  void handleEdit(String id, BuildContext context) {
    final memoState = _ref.read(memoProvider);
    memoState.maybeWhen(
      successed: (memos) {
        final memoIdInt = int.tryParse(id);
        if (memoIdInt != null) {
          final memo = memos.firstWhere((m) => m.memoId == memoIdInt);
          context.push('/edit', extra: memo).then((_) {
            // 에딧 페이지에서 돌아올 때 메모 상태를 갱신
            _ref.read(memoProvider.notifier).getAllMemos();
          });
        }
      },
      orElse: () {},
    );
  }

  /// 에딧 페이지에서 돌아올 때 메모 상태를 갱신
  Future<void> refreshMemoState() async {
    await _ref.read(memoProvider.notifier).getAllMemos();
    _ref.invalidate(memoProvider);
  }
}
