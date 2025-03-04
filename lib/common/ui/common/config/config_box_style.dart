import 'package:flutter/material.dart';

enum BoxSize {
  extraSmall,
  small,
  medium,
  large,
}

class BoxConfig {
  static Widget createContainer({
    required BuildContext context,
    required BoxSize size,
    required Widget child,
    Color? backgroundColor,
  }) {
    return Container(
      padding: _getPadding(size),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(_getRadius(size)),
      ),
      child: child,
    );
  }

  static EdgeInsets _getPadding(BoxSize size) {
    switch (size) {
      case BoxSize.extraSmall:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case BoxSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case BoxSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      default:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  static double _getRadius(BoxSize size) {
    switch (size) {
      case BoxSize.extraSmall:
        return 8;
      case BoxSize.small:
        return 8;
      case BoxSize.large:
        return 12;
      default:
        return 8;
    }
  }
}
