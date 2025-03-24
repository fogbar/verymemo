import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoDetailProvider = StateNotifierProvider<MemoDetailViewModel, void>((ref) {
  return MemoDetailViewModel(ref);
});

class MemoDetailViewModel extends StateNotifier<void> {
  final Ref _ref;

  MemoDetailViewModel(this._ref) : super(null);

  

  void handleDelete(String id) {
    debugPrint('메모 삭제 요청: $id');
    // TODO: 삭제 로직 구현
  }


  void handleShare(String id) {
    debugPrint('공유 요청: $id');
    // TODO: 공유 로직 구현
  }
}