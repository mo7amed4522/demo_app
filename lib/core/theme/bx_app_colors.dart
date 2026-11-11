// File: lib/core/themes/bx_app_colors.dart
// Architecture: Core Layer - Bx App Colors
// Purpose: Define the colors for the application

import 'package:flutter/material.dart';

class BxAppColors {
  BxAppColors._();

  // --- Brand Colors (From Design) ---
  /// Deep Navy background
  static const Color background = Color(0xFF0B1B40);

  /// Off-white surface for cards
  static const Color surface = Color(0xFFF8F9FA);

  /// Primary Blue (Button gradient start / icons)
  static const Color primary = Color(0xFF0056D2);

  /// Light Blue (Button gradient end)
  static const Color secondary = Color(0xFF00C6FF);

  /// Gold/Yellow accent
  static const Color accentGold = Color(0xFFFFD54F);

  // --- Semantic Colors ---
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF0288D1);

  // --- Neutral Colors ---
  /// White text on dark backgrounds
  static const Color onBackground = Color(0xFFFFFFFF);

  /// Dark text on off-white surfaces
  static const Color onSurface = Color(0xFF1C1E24);

  /// Text color on primary buttons
  static const Color onPrimary = Color(0xFFFFFFFF);

  // --- Dark Theme Specifics (Matches Design) ---
  static const Color darkBackground = background;
  static const Color darkSurface = surface;
  static const Color darkOnBackground = onBackground;
  static const Color darkOnSurface = onSurface;
}
