import 'package:verymemo/features/memo/domain/models/memo_model.dart';

abstract class MemoRepository {
  /// [Create Memo]
  Future<void> addMemo(MemoModel memo);

  /// [Read Memo]
  Future<MemoModel?> getMemoById(int memoId);
  Future<List<MemoModel>?> getAllMemos();

  /// [Update Memo]
  Future<int> updateMemo(MemoModel memo);

  /// [Delete Memo]
  Future<int> deleteMemo(int memoId);
}
