import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 메모 정렬 기준
enum MemoSortType {
  @JsonValue(0)
  lastViewed('최근 조회순'),
  @JsonValue(1)
  latest('최신 작성일'),
  @JsonValue(2)
  oldest('오래된 작성일');

  final String label;
  const MemoSortType(this.label);
}

/// 메모 정렬 프로바이더
final memoSortProvider =
    StateNotifierProvider<MemoSortNotifier, MemoSortType>((ref) {
  return MemoSortNotifier();
});

class MemoSortNotifier extends StateNotifier<MemoSortType> {
  MemoSortNotifier() : super(MemoSortType.lastViewed);

  void changeSortType(MemoSortType type) {
    state = type;
  }
}
