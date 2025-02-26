import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/list/memo_list/memo_list.dart';
import 'package:verymemo/features/memo/presentation/memo_home_viewmodel.dart';

class MemoHomeView extends ConsumerWidget {
  const MemoHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoListProvider);
    return MemoList(viewModel: viewModel);
  }
}
