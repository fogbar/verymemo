import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_popup.dart';

class DeleteMemoPopup extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteMemoPopup({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ModalPopup(
      title: "메모를 삭제하시겠어요?",
      subtitle: "삭제된 메모는 복구할 수 없습니다.",
      iconKey: "delete",
      confirmText: "삭제",
      cancelText: "취소",
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
