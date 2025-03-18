import 'dart:developer';

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
      try {
        // 🔄 memos 테이블에 저장 및 memoId 획득
        final memoData = dto.toJson();
        ("---> Memo 데이터: $memoData");
        final memoId = await txn.insert(tableName[0], memoData);
        ("---> Memo 저장 완료. ID: $memoId");

        // 🔄 images 테이블에 저장
        if (images.isNotEmpty) {
          final imageBatch = txn.batch();
          for (var image in images) {
            imageBatch.insert(tableName[2], {
              'memoId': memoId,
              'imageUrl': image.imageUrl,
              'description': image.description ?? '',
            });
          }
          await imageBatch.commit(noResult: true);
          ("---> 이미지 저장 완료");
        }

        // 🔄 links 테이블에 저장
        if (links.isNotEmpty) {
          final linkBatch = txn.batch();
          log("\n=== 링크 저장 과정 상세 로그 ===");
          log("전달받은 원본 LinkDTO 데이터:");
          for (var link in links) {
            log("""
원본 링크 데이터:
- URL: ${link.linkUrl}
- 썸네일: ${link.thumbnail}
- 제목: ${link.metaTitle}
- 설명: ${link.metaDescription}
            """);

            if (link.linkUrl.isEmpty) {
              continue;
            }
            final linkData = {
              'memoId': memoId,
              'linkUrl': link.linkUrl,
              'thumbnail': link.thumbnail ?? '',
              'metaTitle': link.metaTitle ?? '',
              'metaDescription': link.metaDescription ?? '',
            };
            log("""
DB에 저장할 데이터:
- URL: ${linkData['linkUrl']}
- 썸네일: ${linkData['thumbnail']}
- 제목: ${linkData['metaTitle']}
- 설명: ${linkData['metaDescription']}
            """);
            linkBatch.insert(tableName[3], linkData);
          }
          await linkBatch.commit(noResult: true);
          log("=== 링크 저장 완료 ===\n");
        }

        // 🔄 tags 테이블에 저장
        if (tags.isNotEmpty) {
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
          ("---> 태그 저장 완료");
        }

        ("---> 트랜잭션 완료");
      } catch (e, stackTrace) {
        ("---> DB 저장 실패: $e");
        ("---> 스택트레이스: $stackTrace");
        rethrow;
      }
    });
  }

  /// [Read Memo]
  Future<List<MemoModel>?> getAllMemos() async {
    final db = await dbService.database;
    try {
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

        log("\n=== 링크 데이터 변환 과정 ===");
        log("1. DB에서 가져온 원본 데이터:");
        for (var link in linkResults) {
          log(link.toString());
        }

        final linkDTOs = linkResults.map((e) => LinkDTO.fromJson(e)).toList();
        log("\n2. DTO로 변환된 데이터:");
        for (var dto in linkDTOs) {
          log("linkUrl: ${dto.linkUrl}");
          log("thumbnail: ${dto.thumbnail}");
          log("metaTitle: ${dto.metaTitle}");
          log("metaDescription: ${dto.metaDescription}");
        }

        final linkModels = LinkMapper.toModel(linkDTOs);
        log("\n3. Model로 변환된 데이터:");
        for (var model in linkModels) {
          log("linkUrl: ${model.linkUrl}");
          log("thumbnail: ${model.thumbnail}");
          log("metaTitle: ${model.metaTitle}");
          log("metaDescription: ${model.metaDescription}");
        }
        log("=== 변환 과정 완료 ===\n");

        // 🔄 tags 불러오기 (N:M 관계 처리)
        final tagResults = await db.rawQuery('''
      SELECT t.* FROM tags t
      INNER JOIN memo_tags mt ON t.id = mt.tagId
      WHERE mt.memoId = ?
    ''', [memoId]);
        // 🔄 MemoDTO → MemoModel 변환 + 확장
        final memoDTO = MemoDTO.fromJson2(memo);
        log("image: $imageResults \n link: $linkResults \n tag: $tagResults");
        memoModels.add(MemoMapper.toModel(
          memoDTO,
          images: imageResults.map((e) => ImageDTO.fromJson(e)).toList(),
          links: linkDTOs,
          tags: tagResults.map((e) => TagDTO.fromJson(e)).toList(),
        ));
      }

      return memoModels;
    } catch (e) {
      log("---> getAllMemos Error: $e");
      return null;
    }
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
    final linkDTOs = linkResults.map((e) => LinkDTO.fromJson(e)).toList();

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
      links: linkDTOs,
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
          'linkUrl': link.linkUrl,
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
  Future<int> deleteMemos(List<int> memoIds) async {
    final db = await dbService.database;
    return await db.transaction((txn) async {
      int count = 0;
      for (final memoId in memoIds) {
        await txn
            .delete(tableName[2], where: 'memoId = ?', whereArgs: [memoId]);
        await txn
            .delete(tableName[3], where: 'memoId = ?', whereArgs: [memoId]);
        await txn.delete('memo_tags', where: 'memoId = ?', whereArgs: [memoId]);
        final deleted = await txn
            .delete(tableName[0], where: 'id = ?', whereArgs: [memoId]);
        if (deleted > 0) count++;
      }
      return count; // 🔄 삭제된 개수 반환
    });
  }
}
