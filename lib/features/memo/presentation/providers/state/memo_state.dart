import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';

part 'memo_state.freezed.dart';

@freezed
class MemoState with _$MemoState {
  const factory MemoState.initial() = MemoInitial; // 초기 상태
  const factory MemoState.loading() = MemoLoading; // 로딩 중
  const factory MemoState.successed(List<MemoModel> memos) =
      MemoLoaded; // 데이터 로드 완료
  const factory MemoState.error(String message) = MemoError; // 에러 발생
}
