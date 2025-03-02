import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/common/ui/common/app_theme.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final themeProvider = Provider<ThemeData>((ref) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return isDarkMode
      ? ThemeData(
          colorScheme: darkThemeColors(null),
          textTheme: textTheme(null),
          inputDecorationTheme: inputDecorationTheme(null),
          useMaterial3: true,
        )
      : ThemeData(
          colorScheme: lightThemeColors(null),
          textTheme: textTheme(null),
          inputDecorationTheme: inputDecorationTheme(null),
          useMaterial3: true,
        );
});
