import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/ui/components/list/memo_list/molicure/memo_item.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';

class MemoList extends ConsumerWidget {
  // final MemoHomeViewModel viewModel;

  const MemoList({
    // required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoProvider);
    return state.when(
      initial: () => const Center(child: Text("메모가 없습니다.")),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err) => Center(child: Text("오류 발생: $err")),
      successed: (data) => ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 1000,
        itemBuilder: (context, index) {
          final memo = data[index];
          return MemoItem(memo: memo);
        },
      ),
    );
    // return ListView.builder(
    //   itemCount: , //viewModel.memoList.length,
    //   itemBuilder: (context, index) {
    //     final memo = viewModel.memoList[index];
    //     // 뷰모델 사용 시 이렇게 사용하면 됩니다
    //     // 뷰모델에 있는 데이터를 가져와서 보여주는 방식

    //     return GestureDetector(
    //       onLongPress: () => viewModel.handleMemoLongPress(context, memo),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SizedBox(height: 4),
    //           if (!memo.isLocalMemo) //서버에서 받아온 메모만 프로필 표시
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: ProfileList(
    //                 profileImageUrl: memo.profileImageUrl,
    //                 userName: memo.userName ?? '',
    //                 description: memo.description ?? '',
    //               ),
    //             ),
    //           const SizedBox(height: 4),
    //           if (memo.memoContent != null)
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: MemoContent(text: memo.memoContent!),
    //             ),
    //           const SizedBox(height: 4),
    //           if (memo.imageUrls != null && memo.imageUrls!.isNotEmpty)
    //             MemoImages(memo: memo),
    //           const SizedBox(height: 4),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: MemoFooter(createdAt: memo.date),
    //           ),
    //           const SizedBox(height: 4),
    //           const Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 16),
    //             child: Divider(),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
