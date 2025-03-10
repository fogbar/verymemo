import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/externals/db/db_scheme.dart';
import 'package:verymemo/externals/db/db_service.dart';
import 'package:verymemo/features/memo/domain/dtos/dto.dart';
import 'package:verymemo/features/memo/domain/mappers/mapper.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

final memoLocalDataSourceProvider = Provider<MemoLocalDataSource>((ref) {
  final dbService = ref.watch(dbServiceProvider);
  return MemoLocalDataSource(dbService);
});

class MemoLocalDataSource {
  final DbService dbService;

  MemoLocalDataSource(this.dbService);

  /// [Create Memo]
  Future<void> addMemo({
    required MemoDTO dto,
    List<ImageDTO> images = const [],
    List<LinkDTO> links = const [],
    List<TagDTO> tags = const [],
  }) async {
    final db = await dbService.database;

    // 🔄 트랜잭션 사용해 원자성 확보
    await db.transaction((txn) async {
      // 🔄 memos 테이블에 저장 및 memoId 획득 (중복 제거)
      final memoId = await txn.insert(tableName[0], dto.toJson());

      // 🔄 images 테이블에 저장 (batch 사용)
      final imageBatch = txn.batch();
      for (var image in images) {
        imageBatch.insert(tableName[2], {
          'memoId': memoId,
          'imageUrl': image.imageUrl,
          'description': image.description ?? '',
        });
      }
      await imageBatch.commit(noResult: true);

      // 🔄 links 테이블에 저장 (batch 사용)
      final linkBatch = txn.batch();
      for (var link in links) {
        linkBatch.insert(tableName[3], {
          'memoId': memoId,
          'url': link.linkUrl,
          'thumbnail': link.thumbnail ?? '',
          'metaTitle': link.metaTitle ?? '',
          'metaDescription': link.metaDescription ?? '',
        });
      }
      await linkBatch.commit(noResult: true);

      // 🔄 tags 테이블에 저장 및 memo_tags 처리 (batch 사용)
      final tagBatch = txn.batch();
      for (var tag in tags) {
        final tagResult = await txn
            .query('tags', where: 'tagName = ?', whereArgs: [tag.tagName]);
        int tagId;

        if (tagResult.isNotEmpty) {
          tagId = tagResult.first['id'] as int;
        } else {
          tagId = await txn.insert(tableName[4], {'tagName': tag.tagName});
        }

        tagBatch.insert(tableName[5], {
          'memoId': memoId,
          'tagId': tagId,
        });
      }
      await tagBatch.commit(noResult: true);
    });
  }

  /// [Read Memo]
  Future<List<MemoModel>?> getAllMemos() async {
    final db = await dbService.database;
    if (!db.isOpen) return null;
    final memoResults = await db.query(tableName[0]);

    // 🔄 memoId별로 images, links, tags 불러오기
    List<MemoModel> memoModels = [];
    for (var memo in memoResults) {
      final memoId = memo['id'] as int;

      // 🔄 images 불러오기
      final imageResults = await db.query(
        tableName[2],
        where: 'memoId = ?',
        whereArgs: [memoId],
      );

      // 🔄 links 불러오기
      final linkResults = await db.query(
        tableName[3],
        where: 'memoId = ?',
        whereArgs: [memoId],
      );

      // 🔄 tags 불러오기 (N:M 관계 처리)
      final tagResults = await db.rawQuery('''
      SELECT t.* FROM tags t
      INNER JOIN memo_tags mt ON t.id = mt.tagId
      WHERE mt.memoId = ?
    ''', [memoId]);

      // 🔄 MemoDTO → MemoModel 변환 + 확장
      final memoDTO = MemoDTO.fromJson(memo);
      memoModels.add(MemoMapper.toModel(
        memoDTO,
        images: imageResults.map((e) => ImageDTO.fromJson(e)).toList(),
        links: linkResults.map((e) => LinkDTO.fromJson(e)).toList(),
        tags: tagResults.map((e) => TagDTO.fromJson(e)).toList(),
      ));
    }

    return memoModels;
  }

  Future<MemoModel?> getMemoById(int memoId) async {
    final db = await dbService.database;
    if (!db.isOpen) return null;
    final result = await db.query(
      tableName[0],
      where: 'id = ?',
      whereArgs: [memoId],
    );

    if (result.isEmpty) return null;

    // 🔄 images 불러오기
    final imageResults = await db.query(
      tableName[2],
      where: 'memoId = ?',
      whereArgs: [memoId],
    );
    final imageList = imageResults.map((e) => ImageDTO.fromJson(e)).toList();

    // 🔄 links 불러오기
    final linkResults = await db.query(
      tableName[3],
      where: 'memoId = ?',
      whereArgs: [memoId],
    );
    final linkList = linkResults.map((e) => LinkDTO.fromJson(e)).toList();

    // 🔄 tags 불러오기 (N:M 관계 처리)
    final tagResults = await db.rawQuery('''
    SELECT t.* FROM tags t
    INNER JOIN memo_tags mt ON t.id = mt.tagId
    WHERE mt.memoId = ?
  ''', [memoId]);
    final tagList = tagResults.map((e) => TagDTO.fromJson(e)).toList();

    // 🔄 MemoDTO → MemoModel 변환 + 확장
    final memoDTO = MemoDTO.fromJson(result.first);
    final memoModel = MemoMapper.toModel(
      memoDTO,
      images: imageList,
      links: linkList,
      tags: tagList,
    );

    return memoModel;
  }

  /// [Update Memo]
  /// [Update Memo]
  Future<int> updateMemo({
    required MemoDTO dto,
    List<ImageDTO> images = const [],
    List<LinkDTO> links = const [],
    List<TagDTO> tags = const [],
  }) async {
    final db = await dbService.database;

    return await db.transaction((txn) async {
      await txn.update(tableName[0], dto.toJson(),
          where: 'id = ?', whereArgs: [dto.id]);
      final memoId = dto.id ?? (throw Exception("메모 ID가 존재하지 않습니다."));

      await txn.delete(tableName[2], where: 'memoId = ?', whereArgs: [memoId]);
      final imageBatch = txn.batch();
      for (var image in images) {
        imageBatch.insert(tableName[2], {
          'memoId': memoId,
          'imageUrl': image.imageUrl,
          'description': image.description ?? '',
        });
      }
      await imageBatch.commit(noResult: true);

      await txn.delete(tableName[3], where: 'memoId = ?', whereArgs: [memoId]);
      final linkBatch = txn.batch();
      for (var link in links) {
        linkBatch.insert(tableName[3], {
          'memoId': memoId,
          'url': link.linkUrl,
          'thumbnail': link.thumbnail ?? '',
          'metaTitle': link.metaTitle ?? '',
          'metaDescription': link.metaDescription ?? '',
        });
      }
      await linkBatch.commit(noResult: true);

      await txn.delete('memo_tags', where: 'memoId = ?', whereArgs: [memoId]);
      final tagBatch = txn.batch();
      for (var tag in tags) {
        final tagResult = await txn
            .query('tags', where: 'tagName = ?', whereArgs: [tag.tagName]);
        int tagId = tagResult.isNotEmpty
            ? tagResult.first['id'] as int
            : await txn.insert('tags', {'tagName': tag.tagName});

        tagBatch.insert('memo_tags', {'memoId': memoId, 'tagId': tagId});
      }
      await tagBatch.commit(noResult: true);

      return memoId;
    });
  }

  /// [Delete Memo]
  Future<int> deleteMemo(int memoId) async {
    final db = await dbService.database;
    return await db.transaction((txn) async {
      await txn.delete(tableName[2], where: 'memoId = ?', whereArgs: [memoId]);
      await txn.delete(tableName[3], where: 'memoId = ?', whereArgs: [memoId]);
      await txn.delete('memo_tags', where: 'memoId = ?', whereArgs: [memoId]);
      return await txn
          .delete(tableName[0], where: 'id = ?', whereArgs: [memoId]);
    });
  }
}
