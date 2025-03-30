import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension on BuildContext {
  void poped([bool? result]) {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop(result ?? true);
    }
  }

  Uri get currentPath => GoRouter.of(this).routeInformationProvider.value.uri;

  /// 2. [Padding / Margin / Size]
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;

  /// 3. [Theme]
  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}
