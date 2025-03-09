import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

abstract class MemoRepository {
  /// [Create Memo]
  Future<int> addMemo(MAP memo);

  /// [Read Memo]
  Future<MemoModel?> getMemo(int memoId);
  Future<List<MemoModel?>> getAllMemos();

  /// [Update Memo]
  Future<int> updateMemo(int memoId, MAP memo);

  /// [Delete Memo]
  Future<int> deleteMemo(int memoId);
}
