/// Defines the application's core constants: images, app metadata,
/// fonts, tokens and runtime data holders.
///
/// This file is part of the **Core Layer** of the architecture.
/// It provides a single source of truth for assets paths, localised
/// strings (via `AppLocalizations`) and shared configuration that
/// does not belong to any specific feature or domain.
///
/// Classes:
/// - [BxAppConstant]: static image asset paths.
/// - [BxAppConfiguration]: app‑level metadata (name, location, URLs,
///   API tokens, localised descriptions, etc.).
/// - [BxAppFonts]: font family names used across the application.
/// - [BxAppData]: global mutable data (current user, language code).
library;

// File: lib/core/constant/bx_app_constant.dart
// Architecture: Core Layer - Bx App Constant
// Purpose: Define the app constant for the application

import 'package:demo_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Holds asset paths for all images and animations used by the app.
///
/// All paths are built from a common [baseImageUrl].
/// This class cannot be instantiated.
class BxAppConstant {
  BxAppConstant._();

  /// Base directory for image assets.
  static const String baseImageUrl = 'assets/images/';

  // logo images
  /// Application logo image.
  static const String appLogo = '${baseImageUrl}app_logo.png';
  // shield images
  /// Shield icon image.
  static const String shieldIcon = '${baseImageUrl}shield.png';
  // google images
  /// Google icon image.
  static const String googleIcon = '${baseImageUrl}google.png';
  // apple images
  /// Apple icon image.
  static const String appleIcon = '${baseImageUrl}apple-logo.png';
  // app animation in loading
  /// Lottie animation file shown during loading states.
  static const String loadingIcon = '${baseImageUrl}loading_animation.json';
}

/// Application‑wide configuration such as localised display strings,
/// contact details, API tokens and store links.
///
/// All localised values accept a [BuildContext] to fetch the correct
/// language from [AppLocalizations]. Non‑localised values are static constants.
class BxAppConfiguration {
  BxAppConfiguration._();

  /// The display name of the medical center, localised.
  static String bxAppName(BuildContext context) =>
      AppLocalizations.of(context)?.app_name ?? "App Name";
}

/// Font families used throughout the application.
///
/// Typically passed to [TextStyle.fontFamily].
class BxAppFonts {
  BxAppFonts._();

  /// Primary font family (Poppins).
  static const String bxAppFonts = 'Poppins';

  /// Secondary font family (Inter).
  static const String bxAppFontInter = 'Inter';
}

/// Global mutable state that is not covered by a state‑management solution.
///
/// Holds the currently logged‑in user response and the active language code.
/// These should be set after login / language change and are accessed directly.
class BxAppData {
  BxAppData._();

  /// The currently selected locale language code (e.g. 'en', 'ar').
  static String? langCode;
}
