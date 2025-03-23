import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:go_router/go_router.dart';

class MemoDetailView extends ConsumerWidget {
  // final MemoModel memo;
  final String id;

  const MemoDetailView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoState = ref.watch(memoProvider);
    debugPrint('Memo ID: $id');

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => context.pop(),
      //   ),
      // ),
      body: memoState.when(
        initial: () => const Center(child: Text("초기 상태")),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error) => Center(child: Text('에러: $error')),
        successed: (memos) {
          debugPrint('전체 메모 수: ${memos.length}');
          final memoIdInt = int.tryParse(id);
          final currentMemo = memos.firstWhere(
            (m) => m.memoId == memoIdInt,
          );

          // debugPrint('전체 메모 수: ${memos.length}');
          // final currentMemo = memos.firstWhere(
          //   (m) => m.memoId == memo.memoId,
          //   orElse: () {
          //     debugPrint('메모를 찾을 수 없음: ${memo.memoId}');
          //     return memo;
          //   },
          // );
          // debugPrint('현재 메모 내용: ${currentMemo.content}');
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentMemo.content != null)
                  Text(
                    currentMemo.content!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                // // 추가적인 메모 정보 표시 (이미지, 링크 등)
              ],
            ),
          );
        },
      ),
    );
  }
}
