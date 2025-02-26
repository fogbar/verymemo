import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/list/memo_list/memo_list.dart';

class MemoHomeView extends ConsumerWidget {
  const MemoHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MemoList();
  }
}
