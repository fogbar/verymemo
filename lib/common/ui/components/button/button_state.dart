import 'package:flutter/material.dart';

/// ✅ 버튼 상태 정의 (Primary, Secondary, Tertiary 등)
enum ButtonState {
  primary,
  secondary,
  tertiary,
  transparent,
  white,
  black,
  disabled,
}

/// ✅ 버튼 스타일 컨피그 (색상, 스타일 등)
class ButtonStateConfig {
  /// 📌 버튼 상태별 색상 매핑
  static (Color backgroundColor, Color foregroundColor) getButtonColors(
    ColorScheme colorScheme,
    ButtonState state,
  ) {
    switch (state) {
      case ButtonState.secondary:
        return (colorScheme.primaryContainer, colorScheme.onPrimaryContainer);
      case ButtonState.tertiary:
        return (colorScheme.tertiary, colorScheme.onSurface);
      case ButtonState.disabled:
        return (colorScheme.errorContainer, colorScheme.onErrorContainer);
      case ButtonState.transparent:
        return (Colors.transparent, colorScheme.onSurface);
      case ButtonState.black:
        return (colorScheme.inverseSurface, colorScheme.onInverseSurface);
      case ButtonState.primary:
        return (colorScheme.primary, colorScheme.onPrimary);
      case ButtonState.white:
        return (colorScheme.onInverseSurface, colorScheme.inverseSurface);
    }
  }

  /// 📌 버튼 활성화 상태 확인
  static ButtonState getEffectiveState({
    required ButtonState currentState,
    required bool autoDisable,
    required bool hasRequiredData,
    required bool hasOnPressed,
  }) {
    return autoDisable && (!hasRequiredData || !hasOnPressed)
        ? ButtonState.disabled
        : currentState;
  }
}
