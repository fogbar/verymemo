import 'package:flutter/material.dart';

class AppColor {
  static const coral = Color(0xffFF6D75);
  static const lightcoral = Color(0xffFFF1F1);
  static const purple = Color(0xff7C60FD);
  static const lightPurple = Color(0xff9D87FF);
  static const red = Color(0xfff72349);
  static const redbrown = Color(0xffCC6369);
  static const palepink = Color(0xffEEC2C4);
  static const palepurple = Color(0xffF3F1FF);
  static const palegrey = Color(0xffF3F6FB);
  static const grey100 = Color(0xff171717);
  static const grey90 = Color(0xff1C1C1C);
  static const grey80 = Color(0xff2A2A2A);
  static const grey70 = Color(0xff353535);
  static const grey60 = Color(0xff3E3E3E);
  static const grey50 = Color(0xff686868); //606060으로 한단계 낮출지 고민
  static const grey40 = Color(0xff8F8F8F);
  static const grey30 = Color(0xffB9B9B9);
  static const grey20 = Color(0xffD2D2D2);
  static const grey10 = Color(0xffEAEAEA);
  static const grey5 = Color(0xffF2F2F2);
  static const grey0 = Color(0xffFBFBFB);
  static const hover = Color(0xffF7F7F7);
  static const white = Color(0xffffffff);
  static const modal = Color(0x99000000);
}

ColorScheme lightThemeColors([BuildContext? context]) {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.coral,
    onPrimary: AppColor.white,
    primaryContainer: AppColor.lightcoral,
    onPrimaryContainer: AppColor.coral,
    secondary: AppColor.purple,
    onSecondary: AppColor.white,
    secondaryContainer: AppColor.palepurple,
    tertiary: AppColor.palegrey,
    onTertiary: AppColor.grey60,
    tertiaryContainer: AppColor.palegrey,
    onTertiaryContainer: AppColor.grey30,
    error: AppColor.red,
    onError: AppColor.white,
    errorContainer: AppColor.redbrown,
    onErrorContainer: AppColor.palepink,
    surfaceDim: AppColor.hover,
    surface: AppColor.white,
    surfaceBright: AppColor.grey0,
    surfaceContainerLowest: AppColor.grey20,
    surfaceContainerLow: AppColor.grey40,
    surfaceContainer: AppColor.grey80,
    surfaceContainerHigh: AppColor.grey90,
    surfaceContainerHighest: AppColor.grey100,
    onSurface: AppColor.grey70,
    onSurfaceVariant: AppColor.grey50,
    outline: AppColor.grey5,
    outlineVariant: AppColor.grey10,
    scrim: AppColor.modal,
    inverseSurface: AppColor.grey100,
    onInverseSurface: AppColor.white,
  );
}

ColorScheme darkThemeColors([BuildContext? context]) {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.coral,
    onPrimary: AppColor.white,
    primaryContainer: AppColor.grey60,
    onPrimaryContainer: AppColor.white,
    secondary: AppColor.purple,
    onSecondary: AppColor.white,
    secondaryContainer: AppColor.palepurple,
    tertiary: AppColor.grey80,
    onTertiary: AppColor.grey60,
    tertiaryContainer: AppColor.palegrey,
    onTertiaryContainer: AppColor.grey50,
    error: AppColor.red,
    onError: AppColor.white,
    onErrorContainer: AppColor.redbrown,
    surfaceDim: Color(0xff222222),
    surface: AppColor.grey100,
    surfaceBright: AppColor.grey80,
    surfaceContainerLowest: AppColor.grey60,
    surfaceContainerLow: AppColor.grey40,
    surfaceContainer: AppColor.grey5,
    surfaceContainerHigh: AppColor.grey0,
    surfaceContainerHighest: AppColor.grey100,
    onSurface: AppColor.grey10,
    onSurfaceVariant: AppColor.grey30,
    outline: AppColor.grey80,
    outlineVariant: AppColor.grey70,
    scrim: AppColor.modal,
    inverseSurface: AppColor.white,
    onInverseSurface: AppColor.grey100,
  );
}

TextTheme textTheme([BuildContext? context]) => const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'SUIT', fontSize: 56, fontWeight: FontWeight.w600),
      // letterSpacing: -2.24,
      // height: 1.2),
      displayMedium: TextStyle(
          fontFamily: 'SUIT', fontSize: 46, fontWeight: FontWeight.w600),
      // letterSpacing: -1.84,
      // height: 1.2),
      displaySmall: TextStyle(
          fontFamily: 'SUIT', fontSize: 36, fontWeight: FontWeight.w600),
      // letterSpacing: -1.44,
      // height: 1.2),
      headlineLarge: TextStyle(
          fontFamily: 'SUIT', fontSize: 32, fontWeight: FontWeight.w600),
      // letterSpacing: -0.64,
      // height: 1.2),
      headlineMedium: TextStyle(
          fontFamily: 'SUIT', fontSize: 28, fontWeight: FontWeight.w600),
      // letterSpacing: -0.56,
      // height: 1.2),
      headlineSmall: TextStyle(
          fontFamily: 'SUIT', fontSize: 24, fontWeight: FontWeight.w600),
      // letterSpacing: -0.48,
      // height: 1.2),
      titleLarge: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          height: 1.4),
      titleMedium: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          height: 1.4),
      titleSmall: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
          height: 1.4),
      labelLarge: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.4,
          height: 1.4),
      labelMedium: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.4,
          height: 1.4),
      labelSmall: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.4,
          height: 1.3),
      bodyLarge: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          height: 1.5),
      bodyMedium: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          height: 1.5),
      bodySmall: TextStyle(
          fontFamily: 'SUIT',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          height: 1.5),
    );

InputDecorationTheme inputDecorationTheme([BuildContext? context]) {
  final colorScheme = lightThemeColors(context);
  final defaultBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(8),
  );

  return InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.tertiary,
    border: defaultBorder,
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
    errorBorder: defaultBorder.copyWith(
      borderSide: BorderSide(color: colorScheme.error, width: 2),
    ),
    focusedErrorBorder: defaultBorder.copyWith(
      borderSide: BorderSide(color: colorScheme.error, width: 2),
    ),
    disabledBorder: defaultBorder,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // 내부 여백

    // ✅ 힌트 텍스트 스타일 (Placeholder)
    hintStyle: textTheme(context).labelLarge?.copyWith(
          color: colorScheme.onTertiaryContainer,
        ),
    // ✅ 레이블 텍스트 스타일 (labelText)
    labelStyle: textTheme(context).labelSmall?.copyWith(
          color: colorScheme.onSurface,
        ),

    // ✅ 에러 텍스트 스타일
    errorStyle: textTheme(context).labelLarge?.copyWith(
          color: colorScheme.error,
        ),
  );
}

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    colorScheme: lightThemeColors(context),
    textTheme: textTheme(context),
    inputDecorationTheme: inputDecorationTheme(context),
    useMaterial3: true,
  );
}
