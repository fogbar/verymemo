import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/common/ui/components/layout/variable_nevbar.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_detail_viewmodel.dart';
import 'dart:io';
import 'dart:developer';
import 'package:go_router/go_router.dart';

class MemoDetailView extends ConsumerStatefulWidget {
  final String id;

  const MemoDetailView({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<MemoDetailView> createState() => _MemoDetailViewState();
}

class _MemoDetailViewState extends ConsumerState<MemoDetailView> {
  @override
  Widget build(BuildContext context) {
    final memoState = ref.watch(memoProvider);
    final viewModel = ref.read(memoDetailProvider.notifier);
    final isBookmarked = ref.watch(bookmarkStateProvider);

    return Scaffold(
      body: Column(
        children: [
          VariableHeader(
            type: HeaderType.memoDetail,
            onBack: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.go('/home');
              }
            },
            onDelete: () => viewModel.handleDelete(widget.id, context),
            onShare: () => viewModel.handleShare(widget.id),
            onUpload: () => viewModel.handleUpload(widget.id, context),
          ),
          Expanded(
            child: memoState.when(
              initial: () => const Center(child: Text("초기 상태")),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error) => Center(child: Text('에러: $error')),
              successed: (memos) {
                log("---> 메모 목록에서 메모 찾기 시작");
                log("---> 찾을 메모 ID: ${widget.id}");
                log("---> 전체 메모 수: ${memos.length}");

                final currentMemo = memos.firstWhere(
                  (m) => m.memoId.toString() == widget.id,
                  orElse: () {
                    log("---> 메모를 찾을 수 없습니다. ID: ${widget.id}");
                    throw Exception("메모를 찾을 수 없습니다.");
                  },
                );

                log("---> 찾은 메모 ID: ${currentMemo.memoId}");
                log("---> 찾은 메모 내용: ${currentMemo.content}");

                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MemoFooter(
                          createdAt: currentMemo.createdAt,
                          updatedAt: currentMemo.updatedAt,
                        ),
                        const SizedBox(height: 8),
                        if (currentMemo.content != null) ...[
                          Text(
                            currentMemo.content!,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      height: 1.4,
                                    ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 8),
                        ],
                        if (currentMemo.images != null &&
                            currentMemo.images!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentMemo.images!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final imageUrls = currentMemo.images ?? [];
                              final image = imageUrls[index];

                              return GestureDetector(
                                onTap: () => ref
                                    .read(memoHomeProvider.notifier)
                                    .showImageDetail(
                                        context, currentMemo, index),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(image.imageUrl ?? ''),
                                    width: double.infinity,
                                    height: 300,
                                    fit: BoxFit.cover,
                                    cacheWidth: 800,
                                    gaplessPlayback: true,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 300,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.error),
                                              SizedBox(height: 8),
                                              Text('이미지를 불러올 수 없습니다'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        if (currentMemo.links != null &&
                            currentMemo.links!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          LinkLargeView(
                            links: currentMemo.links!,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: VariableNavigationBar(
        ref: ref,
        type: NavigationBarType.content,
        selectedIndex: 0,
        onItemSelected: (index) {
          final viewModel = ref.read(memoDetailProvider.notifier);
          final iconKey = NavigationBarConfig.contentIcons[index];

          if (iconKey == 'copy') {
            viewModel.handleCopy(widget.id, context);
          }
          if (iconKey == 'bookmark') {
            viewModel.handleBookmark(widget.id);
          }
          if (iconKey == 'upload') {
            viewModel.handleUpload(widget.id, context);
          }
          if (iconKey == 'edit') {
            viewModel.handleEdit(widget.id, context);
          }
        },
        iconColors: {
          'bookmark': isBookmarked
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        },
      ),
    );
  }
}
