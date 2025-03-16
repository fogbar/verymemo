import 'package:verymemo/common/barrel/view_common.dart';

final alignStateProvider = StateProvider<String>((ref) => '최근 본 메모');

class AlignSelect {
  static const List<String> options = [
    '최근 본 메모',
    '최신 작성일',
    '오래된 작성일',
  ];

  static void show(BuildContext context, WidgetRef ref) {
    final currentAlign = ref.read(alignStateProvider);
    final highlightedIndices =
        options.map((option) => option == currentAlign).toList();

    ModalSelect.show(
      context: context,
      options: options,
      isHighlighted: highlightedIndices,
      onSelect: (selected) {
        ref.read(alignStateProvider.notifier).state = selected;
        // ref.read(memoHomeViewModelProvider.notifier).sortMemos(selected);
      },
    );
  }
}
