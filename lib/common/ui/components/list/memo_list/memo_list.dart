import 'package:verymemo/common/barrel/memo_list.dart';
import 'package:verymemo/common/barrel/view_common.dart';

class MemoList extends StatelessWidget {
  final MemoListViewModel viewModel;

  const MemoList({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.memoList.length,
      itemBuilder: (context, index) {
        final memo = viewModel.memoList[index];
        // 뷰모델 사용 시 이렇게 사용하면 됩니다
        // 뷰모델에 있는 데이터를 가져와서 보여주는 방식

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
                    description: memo.description ?? '',
                  ),
                ),
              const SizedBox(height: 4),
              if (memo.memoContent != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MemoContent(text: memo.memoContent!),
                ),
              const SizedBox(height: 4),
              if (memo.imageUrls != null && memo.imageUrls!.isNotEmpty)
                MemoImages(memo: memo),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MemoFooter(createdAt: memo.date),
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
    );
  }
}
