import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_state.freezed.dart';

@freezed
class MemoState with _$MemoState {
  const factory MemoState.initial() = MemoInitial; // 초기 상태
  const factory MemoState.loading() = MemoLoading; // 로딩 중
  const factory MemoState.loaded(List<Map<String, dynamic>> memos) =
      MemoLoaded; // 데이터 로드 완료
  const factory MemoState.error(String message) = MemoError; // 에러 발생
  const factory MemoState.added() = MemoAdded; // 메모 추가 완료
  const factory MemoState.updated() = MemoUpdated; // 메모 업데이트 완료
  const factory MemoState.deleted() = MemoDeleted; // 메모 삭제 완료
}
