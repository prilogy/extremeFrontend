import 'package:flutter/material.dart';

import 'extreme_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: ExtremeColors.base,
      canvasColor: ExtremeColors.base[400],
      // nav bar's background color
      /* theme colors */
      primaryColor: ExtremeColors.primary,
      accentColor: ExtremeColors.primary,
      /* ------------ */
      appBarTheme: AppBarTheme(
          color: ExtremeColors.base[400],
          iconTheme: IconThemeData(color: ExtremeColors.base[100])),
      colorScheme: ColorScheme(
          primary: ExtremeColors.primary,
          primaryVariant: ExtremeColors.primary[500]!,
          secondary: ExtremeColors.primary,
          secondaryVariant: ExtremeColors.primary[500]!,
          surface: ExtremeColors.base[400]!,
          background: ExtremeColors.base,
          error: ExtremeColors.error,
          onPrimary: ExtremeColors.base[100]!,
          onSecondary: ExtremeColors.base[100]!,
          onSurface: ExtremeColors.base[100]!,
          onBackground: ExtremeColors.base[100]!,
          onError: ExtremeColors.base[100]!,
          brightness: Brightness.dark),
      textTheme: new TextTheme(
          subtitle1: TextStyle(fontWeight: FontWeight.w500),
          caption: TextStyle(color: Colors.white))
  );
}
