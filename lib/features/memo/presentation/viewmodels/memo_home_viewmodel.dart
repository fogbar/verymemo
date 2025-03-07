import 'dart:io';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_select.dart';
import 'package:verymemo/features/memo/domain/models/image_model.dart';
import 'package:verymemo/features/memo/domain/models/link_model.dart';
import 'package:verymemo/features/memo/domain/cache/memo_cache.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';

final memoHomeProvider = ChangeNotifierProvider((ref) {
  final memoNotifier = ref.watch(memoProvider.notifier);
  return MemoHomeViewModel(memoNotifier);
});

class MemoHomeViewModel extends ChangeNotifier {
  final MemoNotifier memoNotifier;
  MemoHomeViewModel(this.memoNotifier) {
    getAllMemos();
  }

  Future<void> getAllMemos() async {
    await memoNotifier.getAllMemos();
  }

  List<LinkModel?> extractLinks() {
    final memoList = MemoCache().getAllMemos();
    return memoList
        .where((memo) =>
            memo.links != null &&
            memo.links!.isNotEmpty) // 🔄 null 체크 및 빈 리스트 제외
        .expand((memo) => memo.links!) // 🔄 중첩된 리스트를 평탄화
        .toList(); // 🔄 최종 리스트 반환
  }

  List<MemoModel> extractImages() {
    final memoList = MemoCache().getAllMemos();
    return memoList.where((memo) => memo.imageUrls != null).toList();
  }

  // 이미지 관련 로직 추가
  bool get isDesktopPlatform =>
      kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  int getRemainingCount(List<ImageModel?>? imageUrls) =>
      (imageUrls?.length ?? 0) > 5 ? (imageUrls?.length ?? 0) - 5 : 0;

  int getDisplayCount(List<ImageModel?>? imageUrls) =>
      (imageUrls?.take(5).length ?? 0);

  bool isUseFixedSize(List<ImageModel>? imageUrls) =>
      getDisplayCount(imageUrls) <= 2;

  List<ImageModel?> getDisplayImages(List<ImageModel?>? imageUrls) =>
      imageUrls?.take(5).toList() ?? [];

  bool shouldShowRemainingCount(List<ImageModel?>? imageUrls, int index) =>
      index == 4 && getRemainingCount(imageUrls) > 0;

//딥 클릭 모달
  void handleMemoLongPress(BuildContext context, MemoModel memo) {
    ModalSelect.show(
      context: context,
      options: ['수정', '북마크', '공유', '공개', '삭제'],
      onSelect: (value) => _handleModalSelection(value, memo),
      isHighlighted: [false, false, false, true, true],
    );
  }

  void _handleModalSelection(String value, MemoModel memo) {
    switch (value) {
      case '수정':
        _editMemo(memo);
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
        _deleteMemo(memo);
        break;
    }
  }

  void _editMemo(MemoModel memo) {
    // 수정 로직 구현
  }

  void _bookmarkMemo(MemoModel memo) {
    // 북마크 로직 구현
  }

  void _deleteMemo(MemoModel memo) {
    // 삭제 로직 구현
  }

  void _shareMemo(MemoModel memo) {
    // 공유 로직 구현
  }

  void _togglePublicMemo(MemoModel memo) {
    // 공개/비공개 전환 로직 구현
  }

//이미지 상세 뷰 띄우기
  void showImageDetail(BuildContext context, MemoModel memo, int index) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      builder: (context) => ImageDetailView(
        imageUrl: memo.imageUrls![index].imageUrl,
        imageUrls: memo.imageUrls!,
        currentIndex: index,
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  // 이미지 그리드 관련 함수들
  Widget buildImageGrid(
      BuildContext context, MemoModel memo, List<ImageModel> imageUrls) {
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
            imageUrls[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildRemainingCountOverlay(List<ImageModel> imageUrls) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrls[4].imageUrl,
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
