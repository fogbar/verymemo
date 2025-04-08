import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_sort_provider.dart';

class AlignSelect {
  static Future<void> show(BuildContext context, WidgetRef ref) {
    final currentSortType = ref.read(memoSortProvider);

    // MemoSortType을 String 리스트로 변환
    final options = MemoSortType.values.map((type) => type.label).toList();

    // 현재 선택된 정렬 타입의 인덱스 찾기
    final currentIndex =
        MemoSortType.values.indexWhere((type) => type == currentSortType);

    return ModalSelect.show(
      context: context,
      options: options,
      isHighlighted: List.generate(
        options.length,
        (index) => index == currentIndex,
      ),
      onSelect: (selected) {
        // 선택된 라벨에 해당하는 MemoSortType 찾기
        final selectedType =
            MemoSortType.values.firstWhere((type) => type.label == selected);

        // 정렬 타입 변경
        ref.read(memoSortProvider.notifier).changeSortType(selectedType);
      },
    );
  }
}
