import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

abstract class MemoRepository {
  /// [Create Memo]
  Future<void> addMemo(MemoModel memo);

  /// [Read Memo]
  Future<MemoModel?> getMemoById(int memoId);
  Future<List<MemoModel>?> getAllMemos();

  /// [Update Memo]
  Future<int> updateMemo(MemoModel memo);

  /// [Delete Memo]
  Future<int> deleteMemo(List<int> memoIds);

  /// 사용되지 않는 이미지 파일 정리
  Future<void> cleanupUnusedImages();
}
