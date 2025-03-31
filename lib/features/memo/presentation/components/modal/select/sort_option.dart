import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_sort_provider.dart';

class SortOption extends ConsumerWidget {
  const SortOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSortType = ref.watch(memoSortProvider);

    // return SafeArea(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: MemoSortType.values.map((type) {
    //       return ListTile(
    //         leading: Icon(
    //           currentSortType == type
    //               ? Icons.radio_button_checked
    //               : Icons.radio_button_unchecked,
    //           color: currentSortType == type
    //               ? Theme.of(context).primaryColor
    //               : null,
    //         ),
    //         title: Text(type.label),
    //         onTap: () {
    //           ref.read(memoSortProvider.notifier).changeSortType(type);
    //           Navigator.pop(context);
    //         },
    //       );
    //     }).toList(),
    //   ),
    // );
    return PopupMenuButton<MemoSortType>(
      initialValue: currentSortType,
      tooltip: '정렬',
      icon: const Icon(Icons.sort),
      onSelected: (MemoSortType type) {
        ref.read(memoSortProvider.notifier).changeSortType(type);
      },
      itemBuilder: (BuildContext context) {
        return MemoSortType.values.map((MemoSortType type) {
          return PopupMenuItem<MemoSortType>(
            value: type,
            child: Row(
              children: [
                Icon(
                  currentSortType == type
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 18,
                  color: currentSortType == type
                      ? Theme.of(context).primaryColor
                      : null,
                ),
                const SizedBox(width: 8),
                Text(type.label),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
