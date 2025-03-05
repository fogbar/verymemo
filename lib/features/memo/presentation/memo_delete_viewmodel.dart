import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/domain/models/memo_list_model.dart';

class MemoDeleteViewModel extends ChangeNotifier {
  final Set<int> selectedIndices = {};

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  void setSelection(int index, bool isSelected) {
    if (isSelected) {
      selectedIndices.add(index);
    } else {
      selectedIndices.remove(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedIndices.clear();
    notifyListeners();
  }

  // 선택된 메모 삭제
  void deleteSelectedMemos(List<MemoListModel> memoList) {
    // TODO: 선택된 메모들을 삭제하는 로직 구현
    // 예: 서버 API 호출 또는 로컬 DB 업데이트
    clearSelection();
  }

  // 선택된 메모 복원
  void restoreSelectedMemos(List<MemoListModel> memoList) {
    // TODO: 선택된 메모들을 복원하는 로직 구현
    // 예: 서버 API 호출 또는 로컬 DB 업데이트
    clearSelection();
  }

  // 개별 메모 삭제 (스와이프로 삭제할 때 사용)
  void deleteMemo(MemoListModel memo) {
    // TODO: 개별 메모를 삭제하는 로직 구현
    // 예: 서버 API 호출 또는 로컬 DB 업데이트
  }
}

final memoDeleteProvider =
    ChangeNotifierProvider((ref) => MemoDeleteViewModel());
