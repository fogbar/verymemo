import 'package:verymemo/common/barrel/view_common.dart';
import 'package:flutter/foundation.dart';

class ModalSelect extends StatelessWidget {
  final List<String> options;
  final void Function(String) onSelect;
  final bool isLarge; // 스몰/라지 모드 구분
  final List<bool> isHighlighted; // 강조 표시 여부를 저장하는 리스트 추가

  const ModalSelect({
    super.key,
    required this.options,
    required this.onSelect,
    this.isLarge = false, // 기본값: 스몰 모드
    this.isHighlighted = const [], // 기본값으로 빈 리스트 설정
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600 && !kIsWeb;

    if (isMobile) {
      return Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        child: BoxConfig.createContainer(
          context: context,
          size: BoxSize.large,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              ...List.generate(
                options.length,
                (index) => ListTile(
                  title: Text(
                    options[index],
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isHighlighted.length > index &&
                                  isHighlighted[index]
                              ? Theme.of(context).colorScheme.error
                              : null,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    onSelect(options[index]);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(height: 32), // 하단 여백 추가
            ],
          ),
        ),
      );
    } else {
      // PC: 드롭다운으로 표시
      return Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map(
                  (option) => InkWell(
                    onTap: () => onSelect(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color:
                              isHighlighted.length > options.indexOf(option) &&
                                      isHighlighted[options.indexOf(option)]
                                  ? Colors.red
                                  : null,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }

  static Future<void> show({
    required BuildContext context,
    required List<String> options,
    required Function(String) onSelect,
    bool isLarge = false,
    List<bool> isHighlighted = const [], // show 메서드에도 매개변수 추가
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Theme.of(context).colorScheme.scrim,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => ModalSelect(
        options: options,
        onSelect: onSelect,
        isLarge: isLarge,
        isHighlighted: isHighlighted, // 매개변수 전달
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:verymemo/components/atom/title_subtitle.dart';
// import 'package:verymemo/components/buttons/index_buttons.dart';
// import 'package:verymemo/styles/index_styles.dart';

// class ModalPopup extends StatelessWidget with ModalStyle {
//   final String title;
//   final String subtitle;
//   final VoidCallback onConfirm;
//   final VoidCallback onCancel;

//   const ModalPopup({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.onConfirm,
//     required this.onCancel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final config = getModalConfig(ModalType.popupSelect);

//     return createModalContainer(
//       type: ModalType.popupSelect,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // 아이콘 섹션
//           Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//             ),
//             child: Icon(
//               Icons.check_circle,
//               color: Theme.of(context).colorScheme.primary,
//               size: 32,
//             ),
//           ),
//           SizedBox(height: config.verticalSpacing),

//           // 텍스트 섹션
//           TitleSubtitle(
//             title: title,
//             subtitle: subtitle,
//             titleSize: TitleSize.medium,
//             alignment: TitleAlignment.center,
//           ),
//           SizedBox(height: config.verticalSpacing),

//           // 버튼 섹션
//           Column(
//             children: [
//               RoundButton(
//                 text: "확인",
//                 size: BoxSize.medium,
//                 state: RoundButtonState.primary,
//                 onPressed: onConfirm,
//                 isExpanded: true,
//               ),
//               Spacing.vXS,
//               RoundButton(
//                 text: "취소",
//                 size: BoxSize.medium,
//                 onPressed: onCancel,
//                 isExpanded: true,
//                 state: RoundButtonState.secondary,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//     );
//   }
// }
