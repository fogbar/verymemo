import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/components/modal/modal_popup.dart';
import 'package:verymemo/features/cloud_sync/cloud_provider.dart';
import 'package:verymemo/features/cloud_sync/cloud_sync_provider.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';

class SyncModal extends ConsumerWidget {
  const SyncModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 동기화 상태 감시
    final syncState = ref.watch(cloudSyncProvider);

    return ModalPopup(
      title: "데이터를 백업하고\n동기화를 시작합니다",
      subtitle: "서버와 동기화를 시작합니다",
      iconKey: "sync",
      confirmText: "주의사항 확인 후 동기화 시작",
      cancelText: "취소",
      onConfirm: () async {
        try {
          // final syncNotifier = ref.read(cloudSyncProvider.notifier);
          // await syncNotifier.initialize(CloudProvider.googleDrive);
          // await syncNotifier.sync(CloudProvider.googleDrive);
          // 메모 동기화 처리
          final repository = ref.read(memoRepositoryProvider);
          await repository.syncMemoWithFireStore();

          if (context.mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          print('동기화 실패: $e');
          if (context.mounted) {
            String errorMessage = '동기화 실패: $e';

            // 특정 오류 메시지 처리
            if (e.toString().contains('Google 로그인 설정 오류')) {
              errorMessage =
                  'Google 로그인 설정 오류: Google Cloud Console에서 OAuth 클라이언트 ID를 확인하세요.';
            } else if (e.toString().contains('Google 로그인 실패')) {
              errorMessage =
                  'Google 로그인 실패: 앱의 패키지 이름과 SHA-1 인증서 지문이 Google Cloud Console에 등록되어 있는지 확인하세요.';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: '확인',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
        }
      },
      onCancel: () => Navigator.of(context).pop(),
    );
    /*
    return ModalPopup(
      title: "동기화를 위한 클라우드 백업",
      subtitle:
          "개인의 구글 드라이브에 데이터를 백업하고 기기 간 동기화를 진행 합니다. \n-\n 연동되는 다른 디바이스의 메모는 삭제되므로 작성한 메모가 있다면 메모의 저장이 필요한 디바이스에서 동기화를 시작해 주세요",
      iconKey: "sync",
      confirmText: "주의사항 확인 후 동기화 시작",
      cancelText: "취소",
      onConfirm: () async {
        try {
          final syncNotifier = ref.read(cloudSyncProvider.notifier);
          await syncNotifier.initialize(CloudProvider.googleDrive);
          await syncNotifier.sync(CloudProvider.googleDrive);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          print('동기화 실패: $e');
          if (context.mounted) {
            String errorMessage = '동기화 실패: $e';

            // 특정 오류 메시지 처리
            if (e.toString().contains('Google 로그인 설정 오류')) {
              errorMessage =
                  'Google 로그인 설정 오류: Google Cloud Console에서 OAuth 클라이언트 ID를 확인하세요.';
            } else if (e.toString().contains('Google 로그인 실패')) {
              errorMessage =
                  'Google 로그인 실패: 앱의 패키지 이름과 SHA-1 인증서 지문이 Google Cloud Console에 등록되어 있는지 확인하세요.';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: '확인',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }
        }
      },
      onCancel: () => Navigator.of(context).pop(),
    );
    */
  }
}
