import 'package:flutter/material.dart';
import 'package:verymemo/common/ui/components/modal/modal_popup.dart';

class SyncModal extends StatelessWidget {
  const SyncModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalPopup(
      title: "동기화를 위한 클라우드 백업",
      subtitle:
          "개인의 구글 드라이브에 데이터를 백업하고 기기 간 동기화를 진행 합니다. \n-\n 연동되는 다른 디바이스의 메모는 삭제되므로 작성한 메모가 있다면 메모의 저장이 필요한 디바이스에서 동기화를 시작해 주세요",
      iconKey: "sync",
      confirmText: "주의사항 확인 후 동기화 시작",
      cancelText: "취소",
      onConfirm: () {
        // TODO: 동기화 로직 구현
        Navigator.of(context).pop();
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }
}
