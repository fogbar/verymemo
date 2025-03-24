import 'package:verymemo/common/barrel/memo_writing.dart';
import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/barrel/router.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_detail_viewmodel.dart';
import 'dart:io';

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
    final viewModel = ref.read(memoDetailProvider.notifier);
    debugPrint('Memo ID: $id');

    return Scaffold(
      body: Container(
        color: Colors.purple.withOpacity(0.1), // Scaffold 영역
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: VariableHeader(
                type: HeaderType.memoDetail,
                onBack: () => context.go(AppRoute.home),
                onDelete: () => viewModel.handleDelete(id),
                onShare: () => viewModel.handleShare(id),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: memoState.when(
                  initial: () => const Center(child: Text("초기 상태")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error) => Center(child: Text('에러: $error')),
                  successed: (memos) {
                    final memoIdInt = int.tryParse(id);
                    final currentMemo = memos.firstWhere(
                      (m) => m.memoId == memoIdInt,
                    );

                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (currentMemo.content != null)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow.withOpacity(0.2),
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                ),
                                child: Text(
                                  currentMemo.content!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.black,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            if (currentMemo.images != null &&
                                currentMemo.images!.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentMemo.images!.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final imageUrls = currentMemo.images ?? [];
                                  final image = imageUrls[index];
                                  debugPrint(
                                      '이미지 URL $index: ${image.imageUrl}');

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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          debugPrint('이미지 로드 에러: $error');
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
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(0.2),
                                  border:
                                      Border.all(color: Colors.pink, width: 1),
                                ),
                                child: LinkResult(links: currentMemo.links!),
                                
                              ),
                            ],
                          ],
                        ),
                      ),
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
