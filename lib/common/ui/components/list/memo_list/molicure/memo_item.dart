import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/common/ui/components/list/memo_list/molicure/memo_content.dart';
import 'package:verymemo/common/ui/components/list/memo_list/molicure/memo_footer.dart';
import 'package:verymemo/common/ui/components/list/memo_list/molicure/memo_images.dart';

import 'package:verymemo/common/ui/components/list/profile_list/profile_list.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_home_viewmodel.dart';
import 'package:verymemo/routers/router.dart';

class MemoItem extends ConsumerWidget {
  final MemoModel memo;

  const MemoItem({
    required this.memo,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoHomeProvider.notifier);
    return GestureDetector(
      onLongPress: () => viewModel.handleMemoLongPress(context, memo),
      onTap: () => context.go(AppRoute.edit),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileList(
                profileImageUrl: "",
                userName: memo.userId.toString(),
                description: "",
              ),
              const SizedBox(height: 8),
              MemoContent(text: memo.content),
              const SizedBox(height: 8),
              if (memo.imageUrls != null) ...[
                MemoImages(
                    memo: memo, imageUrls: memo.imageUrls), // 🛠 이미지 리스트 위젯 사용
                const SizedBox(height: 8),
              ],
              MemoFooter(createdAt: memo.createdAt),
            ],
          ),
        ),
      ),
    );
  }
}
