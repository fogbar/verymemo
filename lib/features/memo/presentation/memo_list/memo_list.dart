import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';

class MemoList extends ConsumerWidget {
  const MemoList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(memoProvider);
    final viewModel = ref.read(memoHomeProvider.notifier);
    return state.when(
      initial: () => const Center(child: Text("메모가 없습니다.")),
      loading: () => Center(),
      error: (err) => Center(child: Text("오류 발생: $err")),
      successed: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final memo = data[index];
          return GestureDetector(
            onLongPress: () => viewModel.handleMemoLongPress(context, memo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                if (!memo.isLocalMemo) //서버에서 받아온 메모만 프로필 표시
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ProfileList(
                      profileImageUrl: memo.profileImageUrl,
                      userName: memo.userName ?? '',
                      description: "",
                    ),
                  ),
                const SizedBox(height: 4),
                if (memo.content != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MemoContent(text: memo.content!),
                  ),
                const SizedBox(height: 4),
                if (memo.images != null && memo.images!.isNotEmpty)
                  MemoImages(memo: memo),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MemoFooter(createdAt: memo.createdAt),
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
