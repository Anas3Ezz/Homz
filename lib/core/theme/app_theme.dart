import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      error: AppColors.error,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.primaryDarkest,
    ),
  );
}
