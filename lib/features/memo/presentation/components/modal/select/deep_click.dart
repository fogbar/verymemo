import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_select.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

class DeepClickSelect {
  static void show(BuildContext context, MemoModel memo,
      Function(String, MemoModel) onSelect) {
    final options = [
      '수정',
      memo.isBookMarked ? '북마크 해제' : '북마크',
      '공유',
      '공개',
      '삭제'
    ];
    final isHighlighted = [false, memo.isBookMarked, false, true, true];

    ModalSelect.show(
      context: context,
      options: options,
      onSelect: (value) {
        // 북마크/북마크 해제 버튼을 클릭했을 때는 항상 '북마크' 액션으로 처리
        if (value == '북마크' || value == '북마크 해제') {
          onSelect('북마크', memo);
        } else {
          onSelect(value, memo);
        }
      },
      isHighlighted: isHighlighted,
    );
  }
}
