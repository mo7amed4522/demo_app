// File: lib/core/themes/bx_app_theme.dart
// Architecture: Core Layer - Bx App Theme
// Purpose: Define the app theme for the application

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bx_app_colors.dart';

class BxAppTheme {
  BxAppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: BxAppColors.primary,
      brightness: Brightness.light,
      primary: BxAppColors.primary,
      secondary: BxAppColors.secondary,
      error: BxAppColors.error,
      surface: BxAppColors.surface,
      background: const Color(0xFFF0F2F5),
      onPrimary: BxAppColors.onPrimary,
      onSurface: BxAppColors.onSurface,
      onBackground: BxAppColors.onSurface,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: BxAppColors.primary,
        foregroundColor: BxAppColors.onPrimary,
        titleTextStyle: TextStyle(
          color: BxAppColors.onPrimary,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BxAppColors.primary,
          foregroundColor: BxAppColors.onPrimary,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BxAppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: BxAppColors.primary, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
      ),
      textTheme: _buildTextTheme(BxAppColors.onSurface),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: BxAppColors.primary,
      brightness: Brightness.dark,
      primary: BxAppColors.primary,
      secondary: BxAppColors.secondary,
      error: BxAppColors.error,
      surface: BxAppColors.surface, // Off-white cards
      background: BxAppColors.background, // Deep Navy
      onPrimary: BxAppColors.onPrimary,
      onSurface: BxAppColors.onSurface, // Dark text for the card
      onBackground: BxAppColors.onBackground, // White text for the bg
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: BxAppColors.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: BxAppColors.background,
        foregroundColor: BxAppColors.onBackground,
        titleTextStyle: TextStyle(
          color: BxAppColors.onBackground,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BxAppColors.primary,
          foregroundColor: BxAppColors.onPrimary,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: BxAppColors.primary, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
      ),
      cardTheme: CardThemeData(
        color: BxAppColors.surface,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      textTheme: _buildTextTheme(BxAppColors.onSurface),
    );
  }

  static TextTheme _buildTextTheme(Color defaultColor) {
    return TextTheme(
      displayLarge: TextStyle(color: defaultColor, fontSize: 57.sp),
      displayMedium: TextStyle(color: defaultColor, fontSize: 45.sp),
      displaySmall: TextStyle(color: defaultColor, fontSize: 36.sp),
      headlineLarge: TextStyle(
        color: defaultColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: defaultColor,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: defaultColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: defaultColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: defaultColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: defaultColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: defaultColor, fontSize: 16.sp),
      bodyMedium: TextStyle(color: defaultColor, fontSize: 14.sp),
      bodySmall: TextStyle(color: defaultColor, fontSize: 12.sp),
      labelLarge: TextStyle(
        color: defaultColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
