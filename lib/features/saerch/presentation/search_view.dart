import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/layout/variable_header.dart';
import 'package:verymemo/features/saerch/presentation/search_viewmodel.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(searchViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VariableHeader(
              type: HeaderType.searchBar,
              onBack: () => viewModel.onBack(context),
              onSearch: viewModel.onSubmitted,
              onSearchChanged: viewModel.onSearch,
              onSearchClear: viewModel.onClear,
              focusNode: viewModel.focusNode,
            ),
            const Expanded(
              child: Center(
                child: Text('검색 결과가 여기에 표시됩니다'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
