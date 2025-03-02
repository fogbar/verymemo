import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/list/memo_list/memo_list.dart';
import 'package:verymemo/features/memo/presentation/memo_home_viewmodel.dart';
import 'package:verymemo/features/memo/providers/writing_provider.dart';

class MemoHomeView extends ConsumerWidget {
  const MemoHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoListProvider);
    final isWritingVisible = ref.watch(writingStateProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: isWritingVisible
            ? MediaQuery.of(context).size.height * 0.38
            : 0, // 모달 높이와 동일하게 설정
      ),
      child: MemoList(viewModel: viewModel),
    );
  }
}
