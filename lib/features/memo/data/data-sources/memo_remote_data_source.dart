import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

final memoRemoteDataSourceProvider = Provider<MemoRemoteDataSource>(
  (_) => FirestoreMemoDataSource(),
);

abstract class MemoRemoteDataSource {
  Future<String> addMemo(MemoModel memo, int localMemoId);
  Future<Map<int, String>> addMemos(List<MemoModel> memos);
  Future<void> updateMemo(String docId, MemoModel memo);
  Future<void> updateMemos(List<MemoModel> memos);
  Future<void> deleteMemos(List<String> docIds);
  Future<Map<String, dynamic>?> getMemoById(String docId);
  Future<List<MemoModel>?> getAllMemos(String userId);
}

// Firestore 구현체
class FirestoreMemoDataSource implements MemoRemoteDataSource {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('memos');

  /// FireStore에서 저장해주는 docId 를 MemoModel에 저장 필요
  @override
  Future<String> addMemo(MemoModel memo, int localMemoId) async {
    final data = _convertToFirestoreData(memo, localMemoId);
    print("addMemo data: ${data}");
    final docRef = await _collection.add(data);
    print("addMemo docRef: ${docRef}");
    return docRef.id;
  }

  // 청크 단위 업데이트 (create를 최소화하여 비용 최소화)
  @override
  Future<Map<int, String>> addMemos(List<MemoModel> memos) async {
    final docIds = <int, String>{};
    const batchLimit = 500; // 500이 맥시멈

    for (var i = 0; i < memos.length; i += batchLimit) {
      final batch = FirebaseFirestore.instance.batch();
      final chunk = memos.sublist(
          i, i + batchLimit > memos.length ? memos.length : i + batchLimit);

      chunk.forEach((memo) {
        final docRef = _collection.doc();
        final data = _convertToFirestoreData(memo, memo.memoId!);
        batch.set(docRef, data);
        docIds[memo.memoId!] = docRef.id;
      });

      await batch.commit();
    }
    return docIds;
  }

  // 단일 메모 업데이트
  @override
  Future<void> updateMemo(String docId, MemoModel memo) async {
    if (memo.memoId == null) throw Exception("존재하지 않는 메모 입니다");
    final data = _convertToFirestoreData(memo, memo.memoId!);
    print("updateMemo data: ${data}");
    await _collection.doc(docId).update(data);
  }

  // 청크 단위 업데이트 (update를 최소화하여 비용 최소화)
  @override
  Future<void> updateMemos(List<MemoModel> memos) async {
    const batchLimit = 500; // 500이 맥시멈
    List<MemoModel> failedMemos = [];

    for (var i = 0; i < memos.length; i += batchLimit) {
      final batch = FirebaseFirestore.instance.batch();
      final chunk = memos.sublist(
          i, i + batchLimit > memos.length ? memos.length : i + batchLimit);

      chunk.forEach((memo) {
        final data = _convertToFirestoreData(memo, memo.memoId!);
        batch.update(_collection.doc(memo.docId!), data);
      });

      await batch.commit();
    }
  }

  // memoId와 일치하는 FireStore의 docId로 삭제
  @override
  Future<void> deleteMemos(List<String> docIds) async {
    for (final docId in docIds) {
      await _collection.doc(docId).delete();
    }
  }

  /// FireStore의 모든 메모를 가져오는 함수
  ///
  /// userId 파라미터는 로그인한 유저가 작성한 메모만 가져오도록 하기 위함
  ///
  /// 메모 get 부분은 Stream 처리하는게 나을지 생각 필요
  @override
  Future<List<MemoModel>?> getAllMemos(String userId) async {
    print("FirestoreMemoDataSource getAllMemos parmas - userId");
    try {
      // 가장 최근 업데이트 된 메모가 우선 보여지도록 한다.
      // FireStore에서 아래처럼 쿼리를 태울시 index (=색인)을 걸어야 하여 색인 추가함.
      final snapshot = await _collection
          .where('userId', isEqualTo: userId)
          .orderBy('updatedAt', descending: true)
          .get();

      print("getAllMemos - snapshot: ${snapshot}");

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("doc: ${doc}");
        print("data: ${data}");

        // 날짜 파싱
        final createdAt = _parseFirestoreDate(data['createdAt']);
        final updatedAt = _parseFirestoreDate(data['updatedAt']);

        return MemoModel.fromJson({
          ...data,
          'createdAt': createdAt?.toIso8601String(), // ✅ ISO 문자열로 변환
          'updatedAt': updatedAt?.toIso8601String(),
        }).copyWith(docId: doc.id); // 문서 ID 추가 (FireStore에는 따로 처리 X)
      }).toList();
    } catch (e) {
      print("Firestore 조회 오류: $e");
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getMemoById(String docId) async {
    final doc = await _collection.doc(docId).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return {...data, 'docId': doc.id};
  }

  /// 🔥 Firestore 날짜 필드 타입 핸들링 (Timestamp or String)
  DateTime? _parseFirestoreDate(dynamic date) {
    if (date == null) {
      return null;
    } else if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      return DateTime.parse(date); // ISO 8601 형식 문자열 처리
    } else {
      throw Exception('Invalid date type: ${date.runtimeType}');
    }
  }

  // FireStore에 데이터를 업로드 할 때 docId는 올라가면 안되기 때문에 올릴때 docId는 제거하도록 한다.
  // create, update 에서 사용
  Map<String, dynamic> _convertToFirestoreData(
      MemoModel memo, int localMemoId) {
    final json = memo.toJson();

    // 1. docId 제거
    json.remove('docId');

    print("_convertToFirestoreData localMemoId : ${localMemoId}");
    // 2. memoId 추가
    json['memoId'] = localMemoId;

    // 3. 모델에 memoId가 있는 경우 덮어쓰기 (동기화 시 필요)
    if (memo.memoId != null) {
      json['memoId'] = memo.memoId;
    }

    // 4. DateTime → Timestamp 변환
    json['createdAt'] = Timestamp.fromDate(memo.createdAt);
    json['updatedAt'] = Timestamp.fromDate(memo.updatedAt ?? DateTime.now());

    // 5. 중첩 모델 직렬화
    if (json['images'] != null) {
      json['images'] = (json['images'] as List)
          .map((image) => (image as ImageModel).toJson())
          .toList();
    }

    return json;
  }
}
