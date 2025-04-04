import 'package:go_router/go_router.dart';
import 'package:verymemo/common/barrel/model_common.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/memo/presentation/viewmodels/memo_detail_viewmodel.dart';

class MemoDetailView extends ConsumerWidget {
  final String id;

  const MemoDetailView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(memoDetailProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Memo Detail'),
      ),
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
            onDelete: () => viewModel.handleDelete(id, context),
            onShare: () => viewModel.handleShare(id),
          ),
          // ... (rest of the existing code)
        ],
      ),
    );
  }
}
