import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:verymemo/externals/db/db_scheme.dart';
import 'package:verymemo/externals/db/db_service.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  group('MemoRepository Tests', () {
    late ProviderContainer container;

    setUp(() async {
      container = ProviderContainer();

      // 🔄 임시 DB 파일 경로 설정 (테스트용)
      final dbService = container.read(dbServiceProvider);
      await dbService.testInitDB(dbSchemes);
    });

    tearDown(() async {
      final dbService = container.read(dbServiceProvider);
      final db = await dbService.database;
      final dbPath = db.path;

      //
      if (db.isOpen) {
        await db.close();
        await dbService.close();
      }

      // 🔄 `dbPath` 존재 여부 확인 후 삭제
      if (await File(dbPath).exists()) {
        await File(dbPath).delete();
      }

      container.dispose();
    });

    test('addMemo should insert a memo and getMemo should retrieve it',
        () async {
      final memoRepository = container.read(memoRepositoryProvider);

      // 🔄 메모 추가
      final memoId = await memoRepository.addMemo({
        'userId': 1,
        'content': 'This is a test memo',
        'createdAt': DateTime.now().toIso8601String(),
      });
      print('✅ Memo added successfully with ID: $memoId');

      expect(memoId, isNonZero);

      // 🔄 메모 조회
      final memo = await memoRepository.getMemo(memoId);
      print('📋 Retrieved Memo: $memo');
      expect(memo, isNotNull);
      expect(memo!['content'], equals('This is a test memo'));
    });

    test('getMemo should return null for non-existing memo', () async {
      final memoRepository = container.read(memoRepositoryProvider);

      // 🔄 존재하지 않는 메모 조회
      final memo = await memoRepository.getMemo(999);

      expect(memo, isNull);
    });
  });
}
