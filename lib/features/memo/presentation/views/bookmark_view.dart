import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:go_router/go_router.dart';

class BookmarkView extends ConsumerWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoState = ref.watch(memoProvider);

    return memoState.when(
      initial: () => const Center(child: Text("초기 상태")),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => Center(child: Text('에러: $error')),
      successed: (memos) {
        final bookmarkedMemos =
            memos.where((memo) => memo.isBookMarked).toList();

        if (bookmarkedMemos.isEmpty) {
          return const Center(
            child: Text(
              '북마크된 메모가 없습니다',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: bookmarkedMemos.length,
          itemBuilder: (context, index) {
            final memo = bookmarkedMemos[index];
            return GestureDetector(
              onTap: () => context.push('/detail/${memo.memoId}'),
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
        );
      },
    );
  }
}
