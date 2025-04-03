import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/presentation/components/modal/popup/delete.dart';
import 'package:verymemo/features/memo/presentation/providers/memo_provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';

class MemoDeleteViewModel extends ChangeNotifier {
  final Ref _ref;
  final Set<int> selectedIndices = {};

  MemoDeleteViewModel(this._ref);

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

  /// 메모 삭제 다이얼로그를 표시하고 삭제를 처리하는 메서드
  Future<void> deleteMemo(BuildContext context, dynamic memoId) async {
    debugPrint('deleteMemo called with memoId: $memoId');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          debugPrint('DeleteMemoPopup builder called');
          return DeleteMemoPopup(
            onConfirm: () async {
              debugPrint('Delete confirmed');
              Navigator.of(context).pop();

              final List<int> idsToDelete =
                  memoId is int ? [memoId] : List<int>.from(memoId);
              debugPrint('idsToDelete: $idsToDelete');

              await _ref.read(memoProvider.notifier).deleteMemo(idsToDelete);

              if (context.mounted) {
                context.go('/home');
                // 홈 화면의 context를 사용하여 스낵바를 표시합니다
                Future.delayed(const Duration(milliseconds: 500), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('메모가 삭제되었어요'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                });
              }
            },
            onCancel: () {
              debugPrint('Delete cancelled');
              Navigator.of(context).pop();
            },
          );
        },
      );
    });
  }

  // 선택된 메모 삭제
  Future<void> deleteSelectedMemos(List<MemoModel> memoList) async {
    try {
      final idsToDelete =
          selectedIndices.map((index) => memoList[index].memoId!).toList();
      await _ref.read(memoProvider.notifier).deleteMemo(idsToDelete);
      clearSelection();
    } catch (e) {
      log("선택된 메모 삭제 실패: $e");
    }
  }

  // 선택된 메모 복원
  void restoreSelectedMemos(List<MemoModel> memoList) {
    // TODO: 선택된 메모들을 복원하는 로직 구현
    clearSelection();
  }
}

final memoDeleteProvider =
    ChangeNotifierProvider((ref) => MemoDeleteViewModel(ref));
