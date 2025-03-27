import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_select.dart';
import 'package:verymemo/features/memo/domain/models/model.dart';

class DeepClickSelect {
  static void show(BuildContext context, MemoModel memo,
      Function(String, MemoModel) onSelect) {
    ModalSelect.show(
      context: context,
      options: ['수정', '북마크', '공유', '공개', '삭제'],
      onSelect: (value) => onSelect(value, memo),
      isHighlighted: [false, false, false, true, true],
    );
  }
}
