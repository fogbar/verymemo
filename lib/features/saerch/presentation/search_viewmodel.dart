import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:verymemo/routers/router.dart';

part 'search_viewmodel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void build() {
    _textController = TextEditingController();
    _focusNode = FocusNode();

    // 컴포넌트가 생성되면 자동으로 포커스 설정
    Future.microtask(() => _focusNode.requestFocus());

    ref.onDispose(() {
      _textController.dispose();
      _focusNode.dispose();
    });
  }

  TextEditingController get textController => _textController;
  FocusNode get focusNode => _focusNode;

  void onSearch(String value) {
    debugPrint('Search: $value');
    // TODO: 검색 로직 구현
  }

  void onSubmitted() {
    debugPrint('Search submitted');
    // TODO: 검색 실행 로직 구현
  }

  void onClear() {
    _textController.clear();
    debugPrint('Search cleared');
    // TODO: 검색어 초기화 로직 구현
  }

  void onBack(BuildContext context) {
    context.go(AppRoute.home);
  }
}
