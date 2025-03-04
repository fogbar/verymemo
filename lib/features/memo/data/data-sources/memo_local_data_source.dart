import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/externals/db/db_scheme.dart';
import 'package:verymemo/externals/db/db_service.dart';

final memoLocalDataSourceProvider = Provider<MemoLocalDataSource>((ref) {
  final dbService = ref.watch(dbServiceProvider);
  return MemoLocalDataSource(dbService);
});

class MemoLocalDataSource {
  final DbService dbService;

  MemoLocalDataSource(this.dbService);

  /// [Create Memo]
  Future<int> addMemo(MAP memo) async {
    final db = await dbService.database;
    return await db.insert(tableName[0], memo);
  }

  /// [Read Memo]
  Future<List<MAP>> getAllMemos() async {
    final db = await dbService.database;
    final result = await db.query(tableName[0]);
    return result.isNotEmpty ? result : [];
  }

  Future<MAP?> getMemo(int memoId) async {
    final db = await dbService.database;
    if (!db.isOpen) return null;
    final result = await db.query(
      tableName[0],
      where: 'id = ?',
      whereArgs: [memoId],
    );

    return result.isNotEmpty ? result.first : null;
  }

  /// [Update Memo]
  Future<int> updateMemo(int memoId, MAP memo) async {
    final db = await dbService.database;
    return await db.update(
      tableName[0],
      memo,
      where: 'id = ?',
      whereArgs: [memoId],
    );
  }

  /// [Delete Memo]
  Future<int> deleteMemo(int memoId) async {
    final db = await dbService.database;
    return await db.delete(
      tableName[0],
      where: 'id = ?',
      whereArgs: [memoId],
    );
  }
}
