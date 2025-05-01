// lib/utils/app_theme.dart
import 'package:finance_app/constants/styles/styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppStyles.primary,
    scaffoldBackgroundColor: AppStyles.background,
    textTheme: TextTheme(
      titleLarge: AppStyles.heading,
      titleMedium: AppStyles.subheading,
      bodyMedium: AppStyles.bodyText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppStyles.primary,
        textStyle: AppStyles.bodyText,
      ),
    ),
  );
}
