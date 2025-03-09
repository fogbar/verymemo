import 'package:flutter/material.dart';

extension StringStyleExtension on String {
  TextSpan point(BuildContext context) {
    return TextSpan(
      text: this,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextSpan normad(BuildContext context) {
    return TextSpan(
      text: this,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
