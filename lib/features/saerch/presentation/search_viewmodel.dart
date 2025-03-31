import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:verymemo/routers/router.dart';

part 'search_viewmodel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late Timer? _debounce;

  @override
  void build() {
    _textController = TextEditingController();
    _focusNode = FocusNode();

    _textController.addListener(_onSearchListener);

    // 컴포넌트가 생성되면 자동으로 포커스 설정
    Future.microtask(() => _focusNode.requestFocus());

    ref.onDispose(() {
      _textController.dispose();
      _focusNode.dispose();
      _debounce?.cancel();
    });
  }

  TextEditingController get textController => _textController;
  FocusNode get focusNode => _focusNode;

  void _onSearchListener() {
    final value = _textController.text;
    onSearch(value);
  }

  void onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(memoProvider.notifier).searchMemos(value);
    });
  }

  void onSubmitted() {
    debugPrint('Search submitted');
    onSearch(_textController.text);
  }

  void onClear() {
    _textController.clear();
    ref.read(memoProvider.notifier).getAllMemos();
  }

  void onBack(BuildContext context) {
    // context.go(AppRoute.home);
    context.pop();
  }
}
