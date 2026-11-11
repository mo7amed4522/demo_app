// File: lib/core/responsive/bx_breakpoints.dart
// Architecture: Core Responsive - Breakpoints
// Purpose: Define screen size breakpoints for responsive design

import 'dart:ui';

import 'package:flutter/material.dart';

/// Represents the three standard device screen size categories
/// used throughout the application.
///
/// * [mobile] – typically phones (0 – 600px).
/// * [tablet] – typically tablets and small laptops (600 – 1200px).
/// * [desktop] – large screens (> 1200px).
enum BxScreenSize {
  /// Phones and small devices (width < mobile breakpoint).
  mobile, // 300px - 600px
  /// Tablets and small laptops (width between mobile and tablet breakpoints).
  tablet, // 600px - 1200px
  /// Desktop and large screens (width >= tablet breakpoint).
  desktop, // > 1200px
}

/// Configuration class that holds the breakpoint thresholds used to
/// categorise screen widths into [BxScreenSize] values.
///
/// Several pre‑defined sets of breakpoints are available as static getters,
/// inspired by popular frameworks (Material Design, Bootstrap, Tailwind CSS).
///
/// The class also provides methods to query the current screen size from
/// a width, navigate between breakpoints, generate CSS‑like media queries,
/// and validate the breakpoint chain.
class BxResponsiveBreakpoints {
  /// The maximum width considered as mobile.
  /// Defaults to 600 logical pixels.
  final double mobile;

  /// The maximum width considered as tablet.
  /// Defaults to 1200 logical pixels.
  final double tablet;

  /// The starting width for desktop (anything larger than [tablet]).
  /// Defaults to double.infinity for an unbounded upper range.
  final double desktop;

  /// Creates a [BxResponsiveBreakpoints] instance with the given thresholds.
  ///
  /// All values are in logical pixels. The defaults produce a typical
  /// mobile‑first breakpoint set:
  ///
  /// ```dart
  /// const BxResponsiveBreakpoints(mobile: 600, tablet: 1200)
  /// ```
  const BxResponsiveBreakpoints({this.mobile = 600, this.tablet = 1200, this.desktop = double.infinity});

  // Material Design breakpoints (using ScreenUtil)

  /// Breakpoints inspired by Material Design guidelines.
  static BxResponsiveBreakpoints get material => BxResponsiveBreakpoints(mobile: 600, tablet: 1240, desktop: 1440);

  // Bootstrap breakpoints (using ScreenUtil)

  /// Breakpoints matching the Bootstrap 5 responsive breakpoints.
  static BxResponsiveBreakpoints get bootstrap => BxResponsiveBreakpoints(mobile: 768, tablet: 992, desktop: 1200);

  // Tailwind CSS breakpoints (using ScreenUtil)

  /// Breakpoints matching the Tailwind CSS default breakpoints.
  static BxResponsiveBreakpoints get tailwind => BxResponsiveBreakpoints(mobile: 640, tablet: 768, desktop: 1024);

  // Custom breakpoints for specific use cases (using ScreenUtil)

  /// Compact breakpoints for very narrow layouts.
  static BxResponsiveBreakpoints get compact => BxResponsiveBreakpoints(mobile: 480, tablet: 800, desktop: 1024);

  /// Expanded breakpoints for layouts that need more room.
  static BxResponsiveBreakpoints get expanded => BxResponsiveBreakpoints(mobile: 720, tablet: 1440, desktop: 1920);

  /// Returns the [BxScreenSize] category for a given [width] in logical
  /// pixels.
  BxScreenSize getScreenSize(double width) {
    if (width < mobile) return BxScreenSize.mobile;
    if (width < tablet) return BxScreenSize.tablet;
    return BxScreenSize.desktop;
  }

  /// Returns `true` if the width falls in the mobile range.
  bool isMobile(double width) => width >= mobile && width < tablet;

  /// Returns `true` if the width falls in the tablet range.
  bool isTablet(double width) => width >= tablet && width < desktop;

  /// Returns `true` if the width is at or above the desktop breakpoint.
  bool isDesktop(double width) => width >= desktop;

  /// Returns the inclusive‑exclusive range `(min, max)` for a given
  /// [BxScreenSize].
  ///
  /// For mobile: `(0, mobile)`
  /// For tablet: `(mobile, tablet)`
  /// For desktop: `(tablet, desktop)` (where `desktop` is often infinity)
  (double, double) getRange(BxScreenSize size) {
    switch (size) {
      case BxScreenSize.mobile:
        return (0, mobile);
      case BxScreenSize.tablet:
        return (mobile, tablet);
      case BxScreenSize.desktop:
        return (tablet, desktop);
    }
  }

  /// Returns the next breakpoint value that is strictly greater than
  /// [currentWidth], or `null` if the width is already above the highest
  /// breakpoint.
  double? nextBreakpoint(double currentWidth) {
    final breakpoints = [mobile, tablet, desktop];
    breakpoints.sort();

    for (final breakpoint in breakpoints) {
      if (breakpoint > currentWidth) {
        return breakpoint;
      }
    }
    return null;
  }

  /// Returns the largest breakpoint that is strictly less than [currentWidth].
  /// Returns `null` if the width is below the first breakpoint.
  double? previousBreakpoint(double currentWidth) {
    final breakpoints = [mobile, tablet, desktop];
    breakpoints.sort();

    double? previous;
    for (final breakpoint in breakpoints) {
      if (breakpoint < currentWidth) {
        previous = breakpoint;
      }
    }
    return previous;
  }

  /// All breakpoint thresholds as a sorted list.
  List<double> get allBreakpoints => [mobile, tablet, desktop];

  /// Human‑readable names for each breakpoint, in order.
  List<String> get breakpointNames => ['mobile', 'tablet', 'desktop'];

  /// Returns the breakpoint name for a given width.
  String getBreakpointName(double width) {
    final size = getScreenSize(width);
    switch (size) {
      case BxScreenSize.mobile:
        return 'mobile';
      case BxScreenSize.tablet:
        return 'tablet';
      case BxScreenSize.desktop:
        return 'desktop';
    }
  }

  /// Generates a CSS‑style media query string for the given [size].
  ///
  /// When [min] is `true`, it returns a `min‑width` query (e.g.
  /// `(min-width: 0px)` for mobile). When [min] is `false`, it returns
  /// a `max‑width` query except for desktop which still uses `min‑width`
  /// because the upper bound is typically infinite.
  String getMediaQuery(BxScreenSize size, {bool min = true}) {
    final (start, end) = getRange(size);

    if (min) {
      return '(min-width: ${start}px)';
    } else {
      if (end.isFinite) {
        return '(max-width: ${end - 1}px)';
      } else {
        return '(min-width: ${start}px)';
      }
    }
  }

  /// Returns a map of screen size to its corresponding media query string.
  Map<BxScreenSize, String> getMediaQueries({bool min = true}) {
    return {BxScreenSize.mobile: getMediaQuery(BxScreenSize.mobile, min: min), BxScreenSize.tablet: getMediaQuery(BxScreenSize.tablet, min: min), BxScreenSize.desktop: getMediaQuery(BxScreenSize.desktop, min: min)};
  }

  /// Creates a copy of this breakpoint set with the given fields replaced.
  BxResponsiveBreakpoints copyWith({double? mobile, double? tablet, double? desktop}) {
    return BxResponsiveBreakpoints(mobile: mobile ?? this.mobile, tablet: tablet ?? this.tablet, desktop: desktop ?? this.desktop);
  }

  /// Returns `true` if the breakpoints form a valid ascending chain:
  /// `mobile > 0`, `tablet > mobile`, `desktop > tablet`.
  bool get isValid {
    return mobile > 0 && tablet > mobile && desktop > tablet;
  }

  @override
  String toString() {
    return 'BxResponsiveBreakpoints(mobile: $mobile, tablet: $tablet, desktop: $desktop)';
  }
}

/// A collection of static helper methods for responsive design, utilising
/// [BxResponsiveBreakpoints] to calculate values, grid columns, spacing,
/// and to check whether the current device is compact or expanded.
class BreakpointUtils {
  /// The default breakpoints used when no custom set is provided.
  static final defaultBreakpoints = const BxResponsiveBreakpoints();

  /// Linearly interpolates a value between the provided [values] based on
  /// the current screen [width] and an optional list of [breakpoints].
  ///
  /// The number of [breakpoints] must equal the number of [values].
  /// If [breakpoints] is omitted, [defaultBreakpoints.allBreakpoints] is
  /// used. The width is clamped to the nearest segment and the result is
  /// a smooth interpolation using [lerpDouble].
  ///
  /// Example:
  /// ```dart
  /// final fontSize = BreakpointUtils.interpolate(
  ///   width,
  ///   values: [14, 16, 18, 20],
  ///   breakpoints: [0, 600, 900, 1200],
  /// );
  /// ```
  static double interpolate(double width, {required List<double> values, List<double>? breakpoints}) {
    final effectiveBreakpoints = breakpoints ?? defaultBreakpoints.allBreakpoints;

    if (effectiveBreakpoints.length != values.length) {
      throw ArgumentError('Breakpoints and values must have same length');
    }

    // Find appropriate segment
    for (int i = 0; i < effectiveBreakpoints.length - 1; i++) {
      final currentBreakpoint = effectiveBreakpoints[i];
      final nextBreakpoint = effectiveBreakpoints[i + 1];

      if (width >= currentBreakpoint && width < nextBreakpoint) {
        final progress = (width - currentBreakpoint) / (nextBreakpoint - currentBreakpoint);
        return lerpDouble(values[i], values[i + 1], progress)!;
      }
    }

    // If width is beyond last breakpoint, return last value
    return values.last;
  }

  /// Returns a value of type [T] based on the current screen size.
  ///
  /// Uses the [defaultBreakpoints] and the provided per‑size values.
  static T getValueForSize<T>({required BuildContext context, required T watch, required T mobile, required T tablet, required T desktop}) {
    final breakpoints = defaultBreakpoints;
    final width = MediaQuery.of(context).size.width;
    final size = breakpoints.getScreenSize(width);

    switch (size) {
      case BxScreenSize.mobile:
        return mobile;
      case BxScreenSize.tablet:
        return tablet;
      case BxScreenSize.desktop:
        return desktop;
    }
  }

  /// Suggests a number of columns for a grid layout based on the current
  /// screen size and orientation.
  ///
  /// If explicit values are given they take precedence; otherwise sensible
  /// defaults are used (e.g. 2 columns for mobile portrait, 3 for landscape).
  static int getGridColumns({required BuildContext context, int? watchColumns, int? mobileColumns, int? tabletColumns, int? desktopColumns}) {
    final breakpoints = defaultBreakpoints;
    final width = MediaQuery.of(context).size.width;
    final size = breakpoints.getScreenSize(width);

    switch (size) {
      case BxScreenSize.mobile:
        return mobileColumns ?? (MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3);
      case BxScreenSize.tablet:
        return tabletColumns ?? (MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 4);
      case BxScreenSize.desktop:
        return desktopColumns ?? (MediaQuery.of(context).orientation == Orientation.portrait ? 4 : 6);
    }
  }

  /// Returns a spacing value (in logical pixels) appropriate for the
  /// current screen size.
  ///
  /// Defaults: mobile 8.0, tablet 12.0, desktop 16.0.
  static double getSpacing({required BuildContext context, double? mobileSpacing, double? tabletSpacing, double? desktopSpacing}) {
    final breakpoints = defaultBreakpoints;
    final width = MediaQuery.of(context).size.width;
    final size = breakpoints.getScreenSize(width);

    switch (size) {
      case BxScreenSize.mobile:
        return mobileSpacing ?? 8.0;
      case BxScreenSize.tablet:
        return tabletSpacing ?? 12.0;
      case BxScreenSize.desktop:
        return desktopSpacing ?? 16.0;
    }
  }

  /// Returns `true` if the current screen size is mobile (compact).
  static bool isCompact(BuildContext context) {
    final breakpoints = defaultBreakpoints;
    final width = MediaQuery.of(context).size.width;
    final size = breakpoints.getScreenSize(width);

    return size == BxScreenSize.mobile;
  }

  /// Returns `true` if the current screen is tablet or desktop (expanded).
  static bool isExpanded(BuildContext context) {
    final breakpoints = defaultBreakpoints;
    final width = MediaQuery.of(context).size.width;
    final size = breakpoints.getScreenSize(width);

    return size == BxScreenSize.tablet || size == BxScreenSize.desktop;
  }
}
