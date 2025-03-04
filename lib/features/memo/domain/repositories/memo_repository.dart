import 'package:verymemo/common/types/typedef.dart';

abstract class MemoRepository {
  /// [Create Memo]
  Future<int> addMemo(MAP memo);

  /// [Read Memo]
  Future<MAP?> getMemo(int memoId);
  Future<List<MAP?>> getAllMemos();

  /// [Update Memo]
  Future<int> updateMemo(int memoId, MAP memo);

  /// [Delete Memo]
  Future<int> deleteMemo(int memoId);
}
