import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextThemes.lightTextTheme,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTextThemes.darkTextTheme,
    useMaterial3: true,
  );
}
