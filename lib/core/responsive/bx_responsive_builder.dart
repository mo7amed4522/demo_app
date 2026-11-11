/// Builds responsive layouts by selecting a builder function based on the
/// current screen size (mobile, tablet, desktop) and orientation.
///
/// The file also includes [ResponsiveValue] for picking a value per device
/// category, and [ResponsiveLayoutBuilder] for custom layout logic with
/// full size and orientation information.
///
library;

// File: lib/core/responsive/bx_responsive_builder.dart
// Architecture: Core Responsive - Builder
// Purpose: Build responsive layouts based on screen size

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/responsive/bx_breakpoints.dart';
import 'package:demo_app/core/responsive/bx_screen_utils.dart';
import 'package:flutter/material.dart';

/// A widget that builds its child using one of the provided
/// [mobileBuilder], [tabletBuilder], [desktopBuilder], or a generic
/// [builder] depending on the screen size determined by
/// [BxScreenUtils.getScreenSize].
///
/// If the specific builder for the current screen size is `null`,
/// it falls back to [mobileBuilder], and finally to [child] (if given).
/// In landscape mode, a [ConstrainedBox] may be wrapped around the
/// result to limit the width on mobile and tablet devices.
///
/// Example:
/// ```dart
/// BxResponsiveBuilder(
///   mobileBuilder: (ctx) => MobileHomePage(),
///   tabletBuilder: (ctx) => TabletHomePage(),
///   desktopBuilder: (ctx) => DesktopHomePage(),
/// )
/// ```
class BxResponsiveBuilder extends StatelessWidget {
  /// Builder for mobile‑sized screens.
  final WidgetBuilder? mobileBuilder;

  /// Builder for tablet‑sized screens.
  final WidgetBuilder? tabletBuilder;

  /// Builder for desktop‑sized screens.
  final WidgetBuilder? desktopBuilder;

  /// A generic builder that receives the context and returns the widget.
  /// If provided, it takes precedence over the device‑specific builders.
  final WidgetBuilder? builder;

  /// A fallback widget used when no builder matches.
  final Widget? child;

  /// The breakpoints used to classify screen sizes.
  final BxResponsiveBreakpoints breakpoints;

  const BxResponsiveBuilder({
    super.key,
    this.mobileBuilder,
    this.tabletBuilder,
    this.desktopBuilder,
    this.builder,
    this.child,
    this.breakpoints = const BxResponsiveBreakpoints(),
  }) : assert(
         (mobileBuilder != null ||
             tabletBuilder != null ||
             desktopBuilder != null ||
             builder != null ||
             child != null),
         'At least one builder or child must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);
    final orientation = BxScreenUtils.getOrientation(context);
    final width = MediaQuery.of(context).size.width;

    debugPrint('🔍 ResponsiveBuilder DEBUG:');
    debugPrint('   Width: $width');
    debugPrint('   ScreenSize: $screenSize');
    debugPrint('   Orientation: $orientation');
    debugPrint('   Has mobileBuilder: ${mobileBuilder != null}');
    debugPrint('   Has tabletBuilder: ${tabletBuilder != null}');
    debugPrint('   Has desktopBuilder: ${desktopBuilder != null}');

    // Use custom builder if provided
    if (builder != null) {
      return builder!(context);
    }

    // Use specific device type builders
    Widget? widget;
    switch (screenSize) {
      case BxScreenSize.mobile:
        debugPrint('   ✅ Using MOBILE builder');
        widget = mobileBuilder?.call(context);
        break;
      case BxScreenSize.tablet:
        debugPrint('   ✅ Using TABLET builder');
        widget = tabletBuilder?.call(context);
        break;
      case BxScreenSize.desktop:
        debugPrint('   ✅ Using DESKTOP builder');
        widget = desktopBuilder?.call(context);
        break;
    }

    // Fallback to mobile if no specific builder
    if (widget == null) {
      debugPrint('   ⚠️ Fallback to mobile builder');
      widget = mobileBuilder?.call(context);
    }

    // Fallback to child if no builder
    widget ??= child;

    // Apply orientation-specific constraints if needed
    if (orientation == Orientation.landscape) {
      return _applyLandscapeConstraints(context, widget!);
    }

    return widget!;
  }

  /// Wraps the widget in a [ConstrainedBox] to limit maximum width on
  /// mobile and tablet devices when in landscape orientation.
  Widget _applyLandscapeConstraints(BuildContext context, Widget child) {
    final screenSize = BxScreenUtils.getScreenSize(context);

    // Apply different constraints for landscape mode
    switch (screenSize) {
      case BxScreenSize.mobile:
        // Mobile landscape might need different layout
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: child,
        );
      case BxScreenSize.tablet:
        // Tablet landscape can use more width
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: child,
        );
      case BxScreenSize.desktop:
        // Desktop landscape has full width
        return child;
    }
  }
}

/// A helper that resolves a value of type [T] based on the current
/// screen size.
///
/// Use [value] to obtain the appropriate value for the current screen,
/// or [valueOrElse] for custom conditional logic.
///
/// Example:
/// ```dart
/// final fontSize = ResponsiveValue<double>(
///   mobile: 14.0,
///   tablet: 16.0,
///   desktop: 18.0,
/// ).value(context);
/// ```
class ResponsiveValue<T> {
  /// Value for mobile screens.
  final T mobile;

  /// Value for tablet screens.
  final T tablet;

  /// Value for desktop screens.
  final T desktop;

  const ResponsiveValue({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Creates a [ResponsiveValue] where all screen sizes return the same value.
  const ResponsiveValue.all(T value)
    : mobile = value,
      tablet = value,
      desktop = value;

  /// Returns the value corresponding to the screen size of [context].
  T value(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);

    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobile;
      case BxScreenSize.tablet:
        return tablet;
      case BxScreenSize.desktop:
        return desktop;
    }
  }

  /// Returns either [trueValue] or [falseValue] depending on whether the
  /// current screen size satisfies the [condition].
  ///
  /// This uses [BxScreenUtils.currentScreenSize] and does not require a
  /// [BuildContext].
  T valueOrElse({
    required bool Function(BxScreenSize) condition,
    required T trueValue,
    required T falseValue,
  }) {
    return condition(BxScreenUtils.currentScreenSize) ? trueValue : falseValue;
  }
}

/// A widget that passes both the current [BxScreenSize] and [Orientation]
/// to a builder function, giving full control over the responsive layout.
///
/// Useful when you need more flexibility than [BxResponsiveBuilder], e.g.
/// combining size and orientation into a single layout decision.
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// Builder that receives context, current screen size, and orientation.
  final Widget Function(BuildContext, BxScreenSize, Orientation) builder;

  const ResponsiveLayoutBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);
    final orientation = BxScreenUtils.getOrientation(context);

    return builder(context, screenSize, orientation);
  }
}
