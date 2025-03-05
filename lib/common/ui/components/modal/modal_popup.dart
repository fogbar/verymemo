import 'package:verymemo/common/barrel/view_common.dart';
import 'package:verymemo/common/barrel/button.dart';

class ModalPopup extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmText;
  final String cancelText;
  final String iconKey;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ModalPopup({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.cancelText,
    this.iconKey = 'check',
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BoxConfig.createContainer(
        context: context,
        size: BoxSize.large,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 아이콘 섹션
              IconCircleBtn(
                iconKey: iconKey,
                onTap: () {},
                state: ButtonState.secondary,
              ),
              const SizedBox(height: 12),

              // 텍스트 섹션
              TitleSubtitleWidget(
                title: title,
                subtitle: subtitle,
                spacing: 8,
                config: TitleSubtitlePresets.modalPopup,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // 버튼 섹션
              RoundBtnCombinationModal.vertical(
                primaryText: confirmText,
                onPrimaryPressed: onConfirm,
                secondaryText: cancelText,
                onSecondaryPressed: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
