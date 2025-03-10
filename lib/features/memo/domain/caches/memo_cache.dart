import 'package:verymemo/features/memo/domain/models/model.dart';

class MemoCache {
  // 🔄 싱글톤 인스턴스
  static final MemoCache _instance = MemoCache._internal();

  factory MemoCache() => _instance;

  MemoCache._internal();

  // 🔄 메모리 캐시에 저장할 리스트
  final List<MemoModel> _cache = [];

  // 🔄 캐시 초기화
  void clearCache() {
    _cache.clear();
  }

  // 🔄 메모 추가 (기존 캐시에 병합)
  void addMemos(List<MemoModel> memos) {
    // 🔄 중복 방지 및 병합
    final newMemos = memos.where((newMemo) =>
        !_cache.any((cachedMemo) => cachedMemo.memoId == newMemo.memoId));
    _cache.addAll(newMemos);
  }

  // 🔄 모든 메모 가져오기
  List<MemoModel> getAllMemos() {
    return List.unmodifiable(_cache); // 🔄 불변 리스트 반환
  }

  // 🔄 특정 메모 가져오기 (null 안전성)
  MemoModel? getMemoById(int id) {
    try {
      return _cache.firstWhere((memo) => memo.memoId == id);
    } catch (e) {
      return null; // 🔄 없을 경우 null 반환
    }
  }

  // 🔄 메모 업데이트 (존재하는 경우만 교체)
  void updateMemo(MemoModel memo) {
    final index = _cache.indexWhere((m) => m.memoId == memo.memoId);
    if (index != -1) {
      _cache[index] = memo;
    } else {
      _cache.add(memo); // 🔄 없을 경우 추가
    }
  }

  // 🔄 메모 삭제
  void deleteMemo(int id) {
    _cache.removeWhere((memo) => memo.memoId == id);
  }

  // 🔄 메모 존재 여부 체크
  bool containsMemo(int id) {
    return _cache.any((memo) => memo.memoId == id);
  }

  // 🔄 캐시 상태 로깅 (디버깅 용도)
  void logCache() {
    print("🔄 MemoCache 상태: ${_cache.length}개 메모가 캐시에 저장됨.");
    for (var memo in _cache) {
      print("🔄 Memo ID: ${memo.memoId}, 내용: ${memo.content}");
    }
  }
}
