import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/memo/presentation/components/modal/select/deep_click.dart';
import 'package:flutter/services.dart';

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
      loading: () => const Center(),
      error: (err) => Center(child: Text("오류 발생: $err")),
      successed: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final memo = data[index];
          return GestureDetector(
            onTap: () {
              debugPrint('선택된 메모: ${memo.memoId}, ${memo.content}');
              context.push('/detail/${memo.memoId}', extra: memo);
            },
            onLongPress: () async {
              try {
                if (Platform.isIOS || Platform.isAndroid) {
                  await HapticFeedback.mediumImpact();
                  debugPrint('Haptic feedback success');
                }
              } catch (e) {
                debugPrint('Haptic feedback failed: $e');
              }

              DeepClickSelect.show(
                context,
                memo,
                (value, memo) =>
                    viewModel.handleModalSelection(value, memo, context),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!memo.isLocalMemo) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProfileList(
                        profileImageUrl: memo.profileImageUrl,
                        userName: memo.userName ?? '',
                        description: "",
                      ),
                    ),
                  ],
                  if (memo.content != null && memo.content!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: MemoContent(text: memo.content!),
                    ),
                  ],
                  if (memo.links != null && memo.links!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    LinkResult(
                      links: memo.links!,
                    ),
                  ],
                  if (memo.images != null && memo.images!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    MemoImages(memo: memo),
                  ],
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MemoFooter(
                      createdAt: memo.createdAt,
                      updatedAt: memo.updatedAt,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
