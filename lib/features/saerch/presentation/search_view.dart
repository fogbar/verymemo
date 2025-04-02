import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/features/saerch/presentation/search_viewmodel.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(searchViewModelProvider.notifier);
    final state = ref.watch(searchViewModelProvider);

    return Scaffold(
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
              child: state.when(
                initial: () => const Center(child: Text('검색어를 입력하세요')),
                loading: () => const Center(child: CircularProgressIndicator()),
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
                              if (!memo.isLocalMemo)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ProfileList(
                                    profileImageUrl: memo.profileImageUrl,
                                    userName: memo.userName ?? '',
                                    description: '',
                                  ),
                                ),
                              if (memo.content?.isNotEmpty ?? false)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: MemoContent(text: memo.content!),
                                ),
                              if (memo.links?.isNotEmpty ?? false)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: LinkResult(links: memo.links!),
                                ),
                              if (memo.images?.isNotEmpty ?? false)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: MemoImages(memo: memo),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: MemoFooter(createdAt: memo.createdAt),
                              ),
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
          ],
        ),
      ),
    );
  }
}
