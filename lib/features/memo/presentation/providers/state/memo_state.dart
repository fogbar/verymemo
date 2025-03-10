import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

part 'memo_state.freezed.dart';

@freezed
class MemoState with _$MemoState {
  const factory MemoState.initial() = _Initial; // 초기 상태
  const factory MemoState.loading() = _Loading; // 로딩 중
  const factory MemoState.successed(List<MemoModel> memos) =
      _Successed; // 데이터 로드 완료
  const factory MemoState.error(String message) = _Error; // 에러 발생
}
