import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/features/saerch/presentation/search_viewmodel.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(searchViewModelProvider.notifier);
    final state = ref.watch(searchViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            VariableHeader(
              type: HeaderType.searchBar,
              focusNode: viewModel.focusNode,
              controller: viewModel.textController,
              onBack: () => viewModel.onBack(context),
              onSearch: () => viewModel.onSubmitted(),
              onSearchChanged: viewModel.onSearch,
              onSearchClear: viewModel.onClear,
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: state.when(
                  initial: () => const Center(child: Text('검색어를 입력하세요')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e) => Center(child: Text('에러: $e')),
                  successed: (memos) {
                    if (memos.isEmpty) {
                      return const Center(child: Text('검색 결과가 없습니다'));
                    }
                    return ListView.builder(
                      itemCount: memos.length,
                      itemBuilder: (context, index) {
                        final memo = memos[index];
                        return GestureDetector(
                          onTap: () => context.push('/detail/${memo.memoId}'),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!memo.isLocalMemo) ...[
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ProfileList(
                                      profileImageUrl: memo.profileImageUrl,
                                      userName: memo.userName ?? '',
                                      description: "",
                                    ),
                                  ),
                                ],
                                if (memo.content != null &&
                                    memo.content!.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: MemoContent(text: memo.content!),
                                  ),
                                ],
                                if (memo.links != null &&
                                    memo.links!.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  LinkResult(
                                    links: memo.links!,
                                  ),
                                ],
                                if (memo.images != null &&
                                    memo.images!.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  MemoImages(memo: memo),
                                ],
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
