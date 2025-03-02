import 'dart:io';
import 'package:verymemo/features/memo/domain/models/memo_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_select.dart';
import 'package:verymemo/features/memo/presentation/image_detail_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemoListViewModel extends ChangeNotifier {
// 데이터와 로직 관리

  List<MemoListModel> memoList = [
    MemoListModel(
      userName: '하누리',
      description: '우리집 귀요미',
      memoContent:
          'StatefulWidget으로 변경하여 접기/펼치기 상태를 관리합니다.StatefulWidget으로 변경하여 접기/펼치기 상태를 관리합니다.StatefulWidget으로 변경하여 접기/펼치기 상태를 관리합니다.StatefulWidget으로 변경하여 접기/펼치기 상태를 관리합니다. StatefulWidget으로 변경하여 접기/펼치기 상태를 관리합니다.',
      links: [
        LinkData(
          url: 'https://flutter.dev',
          thumbnail:
              'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
          metaTitle:
              '여기는 링크 메타데이터 타이틀입니다. 몇 줄로 제한할지 고민이 됩니다. 몇 줄까지 나오는 걸까요????',
          metaDescription: '서브스크린션 영역입니다',
        ),
      ],
      date: DateTime.now().subtract(const Duration(days: 1)),
      imageUrls: [
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
      ],
      isLocalMemo: true,
    ),
    MemoListModel(
      userName: '장보기 메모',
      description: null,
      memoContent: '사과, 바나나, 우유, 계란, 치즈',
      links: [
        LinkData(
          url: 'https://pub.dev',
          thumbnail:
              'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
          metaTitle: 'Pub.dev - Flutter packages',
          metaDescription:
              'Pub is the package manager for the Dart programming language.',
        ),
      ],
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrls: [],
    ),
    MemoListModel(
      userName: '이미지 많아요',
      description: '여기 영역 제한해야 돼요',
      memoContent: null,
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrls: [
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
        'https://blog.kakaocdn.net/dn/cGbz7k/btsD1mY2YBd/LkWiVVFa4fwyHiCkSW0Ru0/img.png',
      ],
    )
  ];

  List<LinkData> extractLinks() {
    return memoList
        .where((memo) => memo.links != null && memo.links!.isNotEmpty)
        .expand((memo) => memo.links!) //메모안에 복수의 링크가 있으면 모두 새로운 리스트로
        .toList();
  }

  List<MemoListModel> extractImages() {
    return memoList
        .where((memo) => memo.imageUrls != null && memo.imageUrls!.isNotEmpty)
        .toList();
  }

  // 이미지 관련 로직 추가
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

//딥 클릭 모달
  void handleMemoLongPress(BuildContext context, MemoListModel memo) {
    ModalSelect.show(
      context: context,
      options: ['수정', '북마크', '공유', '공개', '삭제'],
      onSelect: (value) => _handleModalSelection(value, memo),
      isHighlighted: [false, false, false, true, true],
    );
  }

  void _handleModalSelection(String value, MemoListModel memo) {
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

  void _editMemo(MemoListModel memo) {
    // 수정 로직 구현
  }

  void _bookmarkMemo(MemoListModel memo) {
    // 북마크 로직 구현
  }

  void _deleteMemo(MemoListModel memo) {
    // 삭제 로직 구현
  }

  void _shareMemo(MemoListModel memo) {
    // 공유 로직 구현
  }

  void _togglePublicMemo(MemoListModel memo) {
    // 공개/비공개 전환 로직 구현
  }

//이미지 상세 뷰 띄우기
  void showImageDetail(BuildContext context, MemoListModel memo, int index) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      builder: (context) => ImageDetailView(
        imageUrl: memo.imageUrls![index],
        imageUrls: memo.imageUrls!,
        currentIndex: index,
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  // 이미지 그리드 관련 함수들
  Widget buildImageGrid(
      BuildContext context, MemoListModel memo, List<String> imageUrls) {
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

final memoListProvider = ChangeNotifierProvider((ref) => MemoListViewModel());
