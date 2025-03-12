import 'dart:io';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/domain/caches/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:verymemo/features/memo/presentation/image_detail_view.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';

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

  /// 🔄 [메모 삭제]
  ///
  Future<void> deleteMemo(dynamic memoId) async {
    final List<int> idsToDelete =
        memoId is int ? [memoId] : List<int>.from(memoId);

    await _ref.read(memoProvider.notifier).deleteMemo(idsToDelete);
    await _loadMemos(); // 🔄 목록 갱신
  }

  /// 🔄 [메모 길게 누를 때]
  void handleModalSelection(String value, MemoModel memo) {
    switch (value) {
      case '수정':
        updateMemo(memo);
        break;
      case '북마크':
        _bookmarkMemo(memo);
        break;
      case '공유':
        _shareMemo(memo);
        break;
      case '공개':
        _togglePublicMemo(memo);
        break;
      case '삭제':
        deleteMemo(memo.memoId!);
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

  void _bookmarkMemo(MemoModel memo) {
    // 북마크 로직 구현
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

//   void sortMemos(String sortOption) {
//     final List<MemoModel> sortedMemos = [...state.memos];

//     switch (sortOption) {
//       case '최근 본 메모':
//         sortedMemos.sort((a, b) => (b.lastViewedAt ?? b.createdAt)
//             .compareTo(a.lastViewedAt ?? a.createdAt));
//       case '최신 작성일':
//         sortedMemos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//       case '오래된 작성일':
//         sortedMemos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//     }

//     state = state.copyWith(memos: sortedMemos);
//   }
}
