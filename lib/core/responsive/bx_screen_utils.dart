// File: lib/core/responsive/bx_screen_utils.dart
// Architecture: Core Responsive - Screen Utilities
// Purpose: Utility functions for screen size and orientation

// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:demo_app/core/responsive/bx_breakpoints.dart';
import 'package:flutter/material.dart';

/// Provides a collection of static helper methods to query screen
/// properties such as size, orientation, safe area, aspect ratio,
/// pixel ratio, and platform brightness.
///
/// It also offers responsive value resolution, breakpoint checks,
/// grid layout suggestions and a global context setter for static
/// access without a `BuildContext`.
///
/// All methods that require a context use [MediaQuery] or other
/// [BuildContext]-dependent APIs.
class BxScreenUtils {
  /// Determines the current [BxScreenSize] based on the screen width.
  ///
  /// Uses the breakpoints defined in [BxResponsiveBreakpoints] to classify
  /// the device as `mobile`, `tablet` or `desktop`.
  static BxScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final breakpoints = const BxResponsiveBreakpoints();
    if (width < breakpoints.mobile) return BxScreenSize.mobile;
    if (width < breakpoints.tablet) return BxScreenSize.tablet;
    return BxScreenSize.desktop;
  }

  /// Returns the current device orientation.
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Returns `true` when the device is in portrait orientation.
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// Returns `true` when the device is in landscape orientation.
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Returns the width of the screen in logical pixels.
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Returns the height of the screen in logical pixels.
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// The top safe area inset (e.g. status bar, notch).
  static double getSafeAreaTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// The bottom safe area inset (e.g. home indicator).
  static double getSafeAreaBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// The left safe area inset.
  static double getSafeAreaLeft(BuildContext context) {
    return MediaQuery.of(context).padding.left;
  }

  /// The right safe area inset.
  static double getSafeAreaRight(BuildContext context) {
    return MediaQuery.of(context).padding.right;
  }

  /// Returns the full [EdgeInsets] representing the safe area insets.
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// The height of the screen minus the top and bottom safe areas.
  static double getAvailableHeight(BuildContext context) {
    final height = getScreenHeight(context);
    final top = getSafeAreaTop(context);
    final bottom = getSafeAreaBottom(context);
    return height - top - bottom;
  }

  /// The width of the screen minus the left and right safe areas.
  static double getAvailableWidth(BuildContext context) {
    final width = getScreenWidth(context);
    final left = getSafeAreaLeft(context);
    final right = getSafeAreaRight(context);
    return width - left - right;
  }

  /// Convenience check for mobile-sized screens.
  static bool isSmallScreen(BuildContext context) {
    return getScreenSize(context) == BxScreenSize.mobile;
  }

  /// Convenience check for tablet or desktop screens.
  static bool isLargeScreen(BuildContext context) {
    return getScreenSize(context) == BxScreenSize.tablet ||
        getScreenSize(context) == BxScreenSize.desktop;
  }

  /// Convenience check for desktop-sized screens.
  static bool isExtraLargeScreen(BuildContext context) {
    return getScreenSize(context) == BxScreenSize.desktop;
  }

  /// Returns the aspect ratio (width / height) of the screen.
  static double getAspectRatio(BuildContext context) {
    final width = getScreenWidth(context);
    final height = getScreenHeight(context);
    return width / height;
  }

  /// Returns `true` when the aspect ratio is greater than 1.5 (wide screen).
  static bool isWideScreen(BuildContext context) {
    return getAspectRatio(context) > 1.5;
  }

  /// Returns `true` when the aspect ratio is less than 0.75 (tall screen).
  static bool isTallScreen(BuildContext context) {
    return getAspectRatio(context) < 0.75;
  }

  /// The device pixel ratio (physical pixels per logical pixel).
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// The system text scale factor chosen by the user.
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// The platform brightness (light or dark) currently active.
  static Brightness getPlatformBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  /// Returns `true` if the platform is currently in dark mode.
  static bool isDarkMode(BuildContext context) {
    return getPlatformBrightness(context) == Brightness.dark;
  }

  /// Returns `true` if the platform is currently in light mode.
  static bool isLightMode(BuildContext context) {
    return getPlatformBrightness(context) == Brightness.light;
  }

  /// Approximates the physical screen size in inches (width, height).
  ///
  /// Uses the formula: logical pixels / (pixelRatio * 160).
  static Size getScreenSizeInInches(BuildContext context) {
    final width = getScreenWidth(context);
    final height = getScreenHeight(context);
    final pixelRatio = getPixelRatio(context);
    final dpi = pixelRatio * 160; // Approximate DPI

    final widthInches = width / dpi;
    final heightInches = height / dpi;

    return Size(widthInches, heightInches);
  }

  /// Approximates the diagonal screen size in inches.
  static double getScreenDiagonalInches(BuildContext context) {
    final size = getScreenSizeInInches(context);
    return sqrt(pow(size.width, 2) + pow(size.height, 2));
  }

  /// Returns the current screen size using a globally stored [BuildContext].
  ///
  /// If no global context is set, defaults to [BxScreenSize.mobile].
  static BxScreenSize get currentScreenSize {
    final context = _globalContext;
    if (context != null) {
      return getScreenSize(context);
    }
    return BxScreenSize.mobile; // Default
  }

  /// The globally stored [BuildContext] for static access.
  ///
  /// Set this once, typically in the root widget's `initState` or
  /// `didChangeDependencies`, to enable [currentScreenSize] and other
  /// static helpers.
  static BuildContext? _globalContext;

  /// Stores a reference to a [BuildContext] for global static use.
  static void setGlobalContext(BuildContext context) {
    _globalContext = context;
  }

  /// Chooses a value based on the current screen size category.
  ///
  /// Requires a value for each of `mobile`, `tablet`, `desktop` and `watch`.
  /// If a [context] is provided it is used to determine the size; otherwise
  /// [currentScreenSize] is used.
  static T responsiveValue<T>({
    required T mobile,
    required T tablet,
    required T desktop,
    required T watch,
    BuildContext? context,
  }) {
    final screenSize = context != null
        ? getScreenSize(context)
        : currentScreenSize;

    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobile;
      case BxScreenSize.tablet:
        return tablet;
      case BxScreenSize.desktop:
        return desktop;
    }
  }

  /// Builds a value dynamically from the screen width.
  ///
  /// The [builder] callback receives the current width (in logical pixels)
  /// and must return a value of type [T]. If no context is provided, it
  /// attempts to use the global context; otherwise it falls back to 360.0.
  static T responsiveValueFromWidth<T>({
    required T Function(double width) builder,
    BuildContext? context,
  }) {
    final width = context != null
        ? getScreenWidth(context)
        : _globalContext != null
        ? getScreenWidth(_globalContext!)
        : 360.0; // Default mobile width

    return builder(width);
  }

  /// Returns `true` if the screen width is at least the given [breakpoint].
  static bool isBreakpoint(BuildContext context, double breakpoint) {
    return getScreenWidth(context) >= breakpoint;
  }

  /// Returns `true` if the screen width is between `min` (inclusive)
  /// and `max` (exclusive).
  static bool isBetweenBreakpoints(
    BuildContext context,
    double min,
    double max,
  ) {
    final width = getScreenWidth(context);
    return width >= min && width < max;
  }

  /// Suggests a number of columns for a grid layout based on the current
  /// screen size and orientation.
  ///
  /// - Mobile portrait: 2, landscape: 3
  /// - Tablet portrait: 3, landscape: 4
  /// - Desktop portrait: 4, landscape: 6
  static int getColumnsForGrid(BuildContext context) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case BxScreenSize.mobile:
        return isPortrait(context) ? 2 : 3;
      case BxScreenSize.tablet:
        return isPortrait(context) ? 3 : 4;
      case BxScreenSize.desktop:
        return isPortrait(context) ? 4 : 6;
    }
  }

  /// Returns a recommended spacing value for grid items based on the
  /// screen size.
  static double getGridItemSpacing(BuildContext context) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case BxScreenSize.mobile:
        return 8.0;
      case BxScreenSize.tablet:
        return 12.0;
      case BxScreenSize.desktop:
        return 16.0;
    }
  }

  /// Prints detailed screen information to the debug console.
  ///
  /// Includes screen size, orientation, dimensions, pixel ratio, text
  /// scale factor, safe area insets, aspect ratio and diagonal size.
  static void printScreenInfo(BuildContext context) {
    final screenSize = getScreenSize(context);
    final orientation = getOrientation(context);
    final width = getScreenWidth(context);
    final height = getScreenHeight(context);
    final pixelRatio = getPixelRatio(context);
    final textScale = getTextScaleFactor(context);
    final safeArea = getSafeAreaInsets(context);

    debugPrint('''
    📱 Screen Information:
    • Size: $screenSize
    • Orientation: $orientation
    • Dimensions: ${width.toStringAsFixed(1)} × ${height.toStringAsFixed(1)}
    • Pixel Ratio: ${pixelRatio.toStringAsFixed(2)}
    • Text Scale: ${textScale.toStringAsFixed(2)}
    • Safe Area: $safeArea
    • Aspect Ratio: ${getAspectRatio(context).toStringAsFixed(2)}
    • Diagonal: ${getScreenDiagonalInches(context).toStringAsFixed(1)} inches
    ''');
  }
}
