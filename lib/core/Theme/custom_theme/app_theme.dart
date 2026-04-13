import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/custom_theme/app_text_theme.dart';
import 'package:to_do_app/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.textColor,
      secondary: AppColors.primary,
      onSecondary: AppColors.textColor,
      error: AppColors.errorColor,
      onError: AppColors.textColor,
      surface: AppColors.primary,
      onSurface: AppColors.textColor,
    ),
    textTheme: AppTextTheme.textTheme,
  );
}
