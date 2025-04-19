import 'package:verymemo/features/memo/domain/models/model.dart';

abstract class MemoRepository {
  /// [Create Memo]
  Future<void> addMemo(MemoModel memo);

  /// [Read Memo]
  Future<MemoModel?> getMemoById(int memoId);
  Future<List<MemoModel>?> getAllMemos(String userId);

  /// [Update Memo]
  Future<int> updateMemo(MemoModel memo);

  /// [Delete Memo]
  Future<int> deleteMemo(List<int> memoIds);

  /// 사용되지 않는 이미지 파일 정리
  Future<void> cleanupUnusedImages();

  Future<List<MemoModel>?> searchMemos(String query);
}
