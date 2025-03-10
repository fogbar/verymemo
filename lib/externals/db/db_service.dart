import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:verymemo/common/configs/storage_key.dart';
import 'package:verymemo/externals/db/db_scheme.dart';

final dbServiceProvider = Provider<DbService>((ref) => DbService());

class DbService {
  static final DbService _instance = DbService._internal();
  DbService._internal();

  static Database? _database;
  factory DbService() => _instance;

  /// [init]
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB(dbSchemes);
    return _database!;
  }

  // 🔄 외부에서 호출할 초기화 함수
  Future<Database> initDB(List<String> tableSchemas) async {
    return await _openDB(
      '$appName.db',
      version: 1,
      tableSchemas: tableSchemas,
    );
  }

  Future<Database> testInitDB(List<String> tableSchemas) async {
    return await _openDB(
      'test_$appName.db',
      version: 1,
      tableSchemas: tableSchemas,
    );
  }

  Future<Database> _openDB(
    String dbName, {
    int version = 1,
    required List<String> tableSchemas,
  }) async {
    final dbPath = await getDatabasesPath();
    final path = join(
      dbPath,
      dbName,
    );
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON;');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS memos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              userId INTEGER NOT NULL,
              content TEXT NOT NULL,
              isLocalMemo INTEGER NOT NULL DEFAULT 0,
              isBookMarked INTEGER NOT NULL DEFAULT 0,
              createdAt TEXT NOT NULL,
              updatedAt TEXT,
              FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
            );
            ''');
        for (final schema in tableSchemas) {
          await db.execute(schema);
        }
      },
    );
  }

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
  }
}
