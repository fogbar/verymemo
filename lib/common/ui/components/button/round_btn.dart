import 'package:flutter/material.dart';
import 'package:verymemo/common/extensions/context_extension.dart';
import 'package:verymemo/common/ui/common/config/config_box_style.dart';
import 'package:verymemo/common/ui/components/button/button_state.dart';
import 'package:verymemo/common/ui/components/button/icon_btn.dart';

/// ✅ 버튼 스타일 컨피그 (색상, 폰트 스타일 등)
class RoundBtnConfig {
  /// 📌 버튼 크기별 텍스트 스타일 매핑
  static TextStyle getTextStyle(
    TextTheme textTheme,
    BoxSize size,
    Color color,
  ) {
    switch (size) {
      case BoxSize.extraSmall:
        return textTheme.labelSmall!.copyWith(color: color);
      case BoxSize.small:
        return textTheme.labelMedium!.copyWith(color: color);
      case BoxSize.large:
        return textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: color,
        );
      default:
        return textTheme.labelLarge!.copyWith(
          color: color,
          letterSpacing: -0.5,
        );
    }
  }
}

/// ✅ 라운드 버튼 위젯
class RoundBtn extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final BoxSize size;
  final ButtonState state;
  final bool autoDisable;
  final bool isExpanded;
  final dynamic leadingIcon;
  final double iconSpacing;

  const RoundBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = BoxSize.medium,
    this.state = ButtonState.primary,
    this.autoDisable = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.scheme;
    final TextTheme textTheme = context.textTheme;

    final effectiveState = ButtonStateConfig.getEffectiveState(
      currentState: state,
      autoDisable: autoDisable,
      hasRequiredData: text != null && text!.isNotEmpty,
      hasOnPressed: onPressed != null,
    );

    final (backgroundColor, foregroundColor) =
        ButtonStateConfig.getButtonColors(
      colorScheme,
      effectiveState,
    );

    final TextStyle textStyle = RoundBtnConfig.getTextStyle(
      textTheme,
      size,
      foregroundColor,
    );

    Widget buttonContent = BoxConfig.createContainer(
      size: size,
      context: context,
      backgroundColor: backgroundColor,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              IconBtn(
                iconKey: leadingIcon,
                size: IconSize.medium,
                color: foregroundColor,
              ),
              SizedBox(width: iconSpacing),
            ],
            Text(text ?? "", style: textStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: effectiveState == ButtonState.disabled ? null : onPressed,
      child: isExpanded
          ? SizedBox(width: double.infinity, child: buttonContent)
          : IntrinsicWidth(child: buttonContent),
    );
  }
}

/// ✅ RoundBtn 조합 익스텐션 - 모달 팝업에 사용됨
extension RoundBtnCombinationModal on RoundBtn {
  /// 수직으로 배치된 주요/보조 버튼 조합
  static Column vertical({
    required String primaryText,
    required VoidCallback? onPrimaryPressed,
    required String secondaryText,
    required VoidCallback? onSecondaryPressed,
    double spacing = 8,
  }) {
    return Column(
      children: [
        RoundBtn(
          text: primaryText,
          onPressed: onPrimaryPressed,
          size: BoxSize.medium,
          state: ButtonState.primary,
          isExpanded: true,
        ),
        SizedBox(height: spacing),
        RoundBtn(
          text: secondaryText,
          onPressed: onSecondaryPressed,
          size: BoxSize.small,
          state: ButtonState.transparent,
          isExpanded: true,
        ),
      ],
    );
  }
}

/// ✅ RoundBtn 조합 익스텐션 - 바텀 버튼에 사용
extension RoundBtnCombinationBottom on RoundBtn {
  /// 수직으로 배치된 주요/보조 버튼 조합
  static Row horizontal({
    required String primaryText,
    required VoidCallback? onPrimaryPressed,
    required String secondaryText,
    required VoidCallback? onSecondaryPressed,
    double spacing = 8,
  }) {
    return Row(
      children: [
        RoundBtn(
          text: secondaryText,
          onPressed: onSecondaryPressed,
          size: BoxSize.large,
          state: ButtonState.secondary,
          isExpanded: true,
        ),
        SizedBox(width: spacing),
        RoundBtn(
          text: primaryText,
          onPressed: onPrimaryPressed,
          size: BoxSize.large,
          state: ButtonState.primary,
          isExpanded: true,
        ),
      ],
    );
  }
}
