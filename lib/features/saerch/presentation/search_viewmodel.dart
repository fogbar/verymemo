import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';
import 'package:verymemo/features/memo/presentation/providers/state/memo_state.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_sort_provider.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';
import 'package:go_router/go_router.dart';

part 'search_viewmodel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  Timer? _debounce;

  @override
  MemoState build() {
    ref.onDispose(() {
      _debounce?.cancel();
      textController.dispose();
      focusNode.dispose();
    });
    return const MemoState.initial();
  }

  final textController = TextEditingController();
  final focusNode = FocusNode();

  Future<void> _performSearch(String text) async {
    if (text.isEmpty) {
      state = const MemoState.initial();
      return;
    }

    state = const MemoState.loading();
    try {
      final repository = ref.read(memoRepositoryProvider);
      final searchResults = await repository.searchMemos(text);
      if (searchResults != null) {
        final sortType = ref.read(memoSortProvider);
        final sortedResults = _sortMemos(searchResults, sortType);
        state = MemoState.successed(sortedResults);
      } else {
        state = const MemoState.successed([]);
      }
    } catch (e) {
      state = MemoState.error('검색 중 오류가 발생했습니다.');
    }
  }

  void onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    textController.text = value;
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _performSearch(value.trim());
    });
  }

  void onSubmitted() async {
    final text = textController.text.trim();
    _debounce?.cancel();
    await _performSearch(text);
    focusNode.unfocus();
  }

  void onClear() {
    textController.clear();
    _debounce?.cancel();
    state = const MemoState.initial();
  }

  void onBack(BuildContext context) {
    textController.clear();
    _debounce?.cancel();
    focusNode.unfocus();
    context.pop();
  }

  List<MemoModel> _sortMemos(List<MemoModel> memos, MemoSortType sortType) {
    switch (sortType) {
      case MemoSortType.lastViewed:
        memos.sort((a, b) => (b.lastViewedAt ?? DateTime.now())
            .compareTo(a.lastViewedAt ?? DateTime.now()));
        break;
      case MemoSortType.latest:
        memos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case MemoSortType.oldest:
        memos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }
    return memos;
  }
}
