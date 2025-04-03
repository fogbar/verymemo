import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/domain/caches/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:verymemo/features/memo/presentation/views/image_detail_view.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';
import 'package:verymemo/features/memo/presentation/components/modal/popup/delete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/routers/router.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
// HapticFeedback을 위해 추가

final memoHomeProvider =
    StateNotifierProvider<MemoHomeViewModel, MemoState>((ref) {
  return MemoHomeViewModel(ref);
});

class MemoHomeViewModel extends StateNotifier<MemoState> {
  final Ref _ref;
  late List<MemoModel> memoList;
  MemoHomeViewModel(this._ref) : super(const MemoState.loading()) {
    memoList = MemoCache().getAllMemos();
  }

  /// 🔄 [메모 로드]
  Future<void> _loadMemos() async {
    await _ref.read(memoProvider.notifier).getAllMemos(); // 🔄 memoProvider 사용
    state = _ref.read(memoProvider); // 🔄 현재 상태 설정
  }

  /// 🔄 [메모 추가]
  Future<void> addMemo(MemoModel memo) async {
    await _ref.read(memoProvider.notifier).addMemo(memo);
    await _loadMemos();
  }

  Future<void> updateMemo(MemoModel memo) async {
    await _ref.read(memoProvider.notifier).updateMemo(memo);
    await _loadMemos();
  }

  /// 🔄 [북마크 토글]
  Future<void> handleBookmark(String memoId) async {
    log("---> handleBookmark 시작: $memoId");
    try {
      final memo =
          await _ref.read(memoProvider.notifier).getMemo(int.parse(memoId));
      if (memo != null) {
        final updatedMemo = memo.copyWith(isBookMarked: !memo.isBookMarked);
        await _ref.read(memoProvider.notifier).updateMemo(updatedMemo);
        await _loadMemos();
      }
    } catch (e) {
      log("❌ Error toggling bookmark: $e");
    }
  }

  /// 🔄 [메모 삭제]
  Future<void> deleteMemo(BuildContext context, dynamic memoId) async {
    debugPrint('deleteMemo called with memoId: $memoId');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          debugPrint('DeleteMemoPopup builder called');
          return DeleteMemoPopup(
            onConfirm: () {
              debugPrint('Delete confirmed');
              Navigator.of(context).pop();

              final List<int> idsToDelete =
                  memoId is int ? [memoId] : List<int>.from(memoId);
              debugPrint('idsToDelete: $idsToDelete');

              _ref
                  .read(memoProvider.notifier)
                  .deleteMemo(idsToDelete)
                  .then((_) {
                _loadMemos();
                context.go('/home');
                // 홈 화면의 context를 사용하여 스낵바를 표시합니다
                Future.delayed(const Duration(milliseconds: 500), () {
                  final homeContext = NavigatorKey.routerKey.currentContext;
                  if (homeContext != null) {
                    ScaffoldMessenger.of(homeContext).showSnackBar(
                      const SnackBar(
                        content: Text('메모가 삭제되었어요'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                });
              });
            },
            onCancel: () {
              debugPrint('Delete cancelled');
              Navigator.of(context).pop();
            },
          );
        },
      );
    });
  }

  void _copyMemo(MemoModel memo, BuildContext context) async {
    if (memo.content != null) {
      await Clipboard.setData(ClipboardData(text: memo.content!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('복사되었습니다'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  /// 🔄 [메모 길게 누를 때]
  void handleModalSelection(BuildContext context, String action) {
    final selectedMemo = _ref.read(selectedMemoIdProvider);
    if (selectedMemo == null) return;

    switch (action) {
      case '수정':
        final memoState = _ref.read(memoProvider);
        memoState.maybeWhen(
          successed: (memos) {
            final memo =
                memos.firstWhere((m) => m.memoId.toString() == selectedMemo);
            context.push('/edit', extra: memo);
          },
          orElse: () {},
        );
        break;
      case '삭제':
        deleteMemo(context, int.tryParse(selectedMemo));
        break;
      case '북마크':
        final memoState = _ref.read(memoProvider);
        memoState.maybeWhen(
          successed: (memos) {
            final memo =
                memos.firstWhere((m) => m.memoId.toString() == selectedMemo);
            _bookmarkMemo(memo);
          },
          orElse: () {},
        );
        break;
      case '복사':
        final memoState = _ref.read(memoProvider);
        memoState.maybeWhen(
          successed: (memos) {
            final memo =
                memos.firstWhere((m) => m.memoId.toString() == selectedMemo);
            _copyMemo(memo, context);
          },
          orElse: () {},
        );
        break;
      case '공유':
        final memoState = _ref.read(memoProvider);
        memoState.maybeWhen(
          successed: (memos) {
            final memo =
                memos.firstWhere((m) => m.memoId.toString() == selectedMemo);
            _shareMemo(memo);
          },
          orElse: () {},
        );
        break;
    }
  }

  // 이미지 관련 로직
  bool get isDesktopPlatform =>
      kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  int getRemainingCount(List<String>? imageUrls) =>
      (imageUrls?.length ?? 0) > 5 ? (imageUrls?.length ?? 0) - 5 : 0;

  int getDisplayCount(List<String>? imageUrls) =>
      (imageUrls?.take(5).length ?? 0);

  bool isUseFixedSize(List<String>? imageUrls) =>
      getDisplayCount(imageUrls) <= 2;

  List<String> getDisplayImages(List<String>? imageUrls) =>
      imageUrls?.take(5).toList() ?? [];

  bool shouldShowRemainingCount(List<String>? imageUrls, int index) =>
      index == 4 && getRemainingCount(imageUrls) > 0;

  void _bookmarkMemo(MemoModel memo) async {
    try {
      log("---> 북마크 토글 시작");
      log("---> 현재 북마크 상태: ${memo.isBookMarked}");
      final updatedMemo = memo.copyWith(
        isBookMarked: !memo.isBookMarked,
      );
      log("---> 업데이트된 북마크 상태: ${updatedMemo.isBookMarked}");

      await _ref.read(memoProvider.notifier).updateMemo(updatedMemo);
      log("---> 북마크 업데이트 완료");
    } catch (e, stackTrace) {
      log("---> 북마크 토글 실패: $e");
      log("---> 스택트레이스: $stackTrace");
    }
  }

  void _shareMemo(MemoModel memo) {
    // 공유 로직 구현
  }

  void _togglePublicMemo(MemoModel memo) {
    // 공개/비공개 전환 로직 구현
  }

//이미지 상세 뷰 띄우기
  void showImageDetail(BuildContext context, MemoModel memo, int initialIndex) {
    final imageUrls = memo.images?.map((e) => e.imageUrl ?? '').toList() ?? [];

    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      builder: (context) => ImageDetailView(
        imageUrl: imageUrls[initialIndex],
        imageUrls: imageUrls,
        currentIndex: initialIndex,
        onClose: () => Navigator.pop(context),
        isLocalFile: memo.isLocalMemo,
        showDelete: true,
        showDownload: !memo.isLocalMemo,
      ),
    );
  }

  // 이미지 그리드 관련 함수들
  Widget buildImageGrid(
      BuildContext context, MemoModel memo, List<String> imageUrls) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isUseFixedSize(imageUrls) ? 2 : 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: getDisplayCount(imageUrls),
      itemBuilder: (context, index) {
        if (shouldShowRemainingCount(imageUrls, index)) {
          return _buildRemainingCountOverlay(imageUrls);
        }
        return GestureDetector(
          onTap: () => showImageDetail(context, memo, index),
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildRemainingCountOverlay(List<String> imageUrls) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrls[4],
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Text(
              '+${getRemainingCount(imageUrls)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
