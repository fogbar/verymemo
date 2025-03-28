import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_popup.dart';

class WithdrawalModal extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const WithdrawalModal({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ModalPopup(
      title: "공유된 데이터가 삭제돼요",
      subtitle:
          "삭제된 데이터는 복구가 불가능합니다.\n 디바이스에 저장된 메모는 탈퇴해도 자동으로 삭제되지 않으니 먼저 메모 전체 삭제를 해 주세요.",
      iconKey: "withdrwal",
      confirmText: "삭제 동의하고 탈퇴하기",
      cancelText: "취소",
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
