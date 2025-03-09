import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/list/memo_list/memo_list.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_home_viewmodel.dart';
import 'package:verymemo/features/memo/presentation/providers/writing_provider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class MemoHomeView extends ConsumerWidget {
  const MemoHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(memoListProvider);

    return CustomRefreshIndicator(
      onRefresh: () async {
        ref.read(writingStateProvider.notifier).toggle();
      },
      builder: (context, child, controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: [
                child,
                if (controller.isLoading)
                  Center(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(controller.value),
                      child: Icon(
                        Icons.add_box,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 0,
        ),
        child: MemoList(viewModel: viewModel),
      ),
    );
  }
}
