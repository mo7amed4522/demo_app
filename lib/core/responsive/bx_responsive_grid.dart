// File: lib/core/responsive/widgets/bx_responsive_grid.dart
// Architecture: Core Responsive - Widgets
// Purpose: Responsive grid layout system with both normal and sliver versions
//
// This file provides a set of widgets that automatically adapt their
// layout (column count, spacing, padding, aspect ratio) based on the
// current screen size (mobile, tablet, desktop) and orientation.
//
// * [ResponsiveGrid] – a full grid using `GridView.builder` with
//   responsive column count and spacing.
// * [ResponsiveSliverGrid] – a sliver version of the grid for use inside
//   a `CustomScrollView`.
// * [ResponsiveGridItem] – an individual grid item that can span
//   multiple columns depending on screen size.
// * [ResponsiveListView] – a `ListView` variant with responsive item
//   spacing.

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/responsive/bx_breakpoints.dart';
import 'package:demo_app/core/responsive/bx_screen_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A responsive grid that automatically adjusts the number of columns,
/// spacing, padding, and child aspect ratio based on the device screen
/// size and orientation.
///
/// It wraps a [GridView.builder] and accepts the same configuration
/// parameters, while also providing screen‑size‑specific overrides for
/// columns, spacing, padding, and aspect ratio.
///
/// If no screen‑size‑specific value is provided, the following defaults
/// are used:
/// - Columns: mobile portrait 2, landscape 3; tablet portrait 3,
///   landscape 4; desktop portrait 4, landscape 6.
/// - Spacing: mobile 8.0, tablet 12.0, desktop 16.0 (or a multiple of
///   the base `spacing` if not specified).
/// - Padding: multiplies the base `padding` by 1.0, 1.5, 2.0 for
///   mobile, tablet, desktop respectively.
/// - Aspect ratio: adjusted for optimal appearance based on column
///   count and screen size.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int? columns;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final int? watchColumns;
  final double spacing;
  final double? mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final double? watchSpacing;
  final EdgeInsets padding;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? watchPadding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool primary;
  final ScrollController? controller;
  final bool reverse;
  final int? itemCount;
  final Widget? separator;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final double? childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.columns,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.watchColumns,
    this.spacing = 8.0,
    this.mobileSpacing,
    this.tabletSpacing,
    this.desktopSpacing,
    this.watchSpacing,
    this.padding = EdgeInsets.zero,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.watchPadding,
    this.shrinkWrap = false,
    this.physics,
    this.primary = false,
    this.controller,
    this.reverse = false,
    this.itemCount,
    this.separator,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);
    final orientation = BxScreenUtils.getOrientation(context);

    // Get responsive values
    final responsiveColumns = _getColumns(screenSize, orientation);
    final responsiveSpacing = _getSpacing(screenSize);
    final responsivePadding = _getPadding(screenSize);

    // Calculate cross axis count
    final crossAxisCount = columns ?? responsiveColumns;

    // Normal GridView
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: responsiveSpacing,
        mainAxisSpacing: responsiveSpacing,
        childAspectRatio:
            childAspectRatio ?? _getAspectRatio(screenSize, crossAxisCount),
      ),
      padding: responsivePadding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      primary: primary,
      controller: controller,
      reverse: reverse,
      itemCount: itemCount ?? children.length,
      itemBuilder: (context, index) => children[index],
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
    );
  }

  /// Returns the appropriate column count based on screen size and orientation.
  int _getColumns(BxScreenSize screenSize, Orientation orientation) {
    // Get base columns for screen size
    int baseColumns;
    switch (screenSize) {
      case BxScreenSize.mobile:
        baseColumns =
            mobileColumns ?? (orientation == Orientation.portrait ? 2 : 3);
        break;
      case BxScreenSize.tablet:
        baseColumns =
            tabletColumns ?? (orientation == Orientation.portrait ? 3 : 4);
        break;
      case BxScreenSize.desktop:
        baseColumns =
            desktopColumns ?? (orientation == Orientation.portrait ? 4 : 6);
        break;
    }

    return baseColumns;
  }

  /// Returns the appropriate spacing value for the given screen size.
  double _getSpacing(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return (mobileSpacing ?? spacing);
      case BxScreenSize.tablet:
        return (tabletSpacing ?? spacing * 1.5);
      case BxScreenSize.desktop:
        return (desktopSpacing ?? spacing * 2.0);
    }
  }

  /// Returns the appropriate padding for the grid based on screen size.
  EdgeInsets _getPadding(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return (mobilePadding ?? padding);
      case BxScreenSize.tablet:
        return (tabletPadding ?? padding * 1.5);
      case BxScreenSize.desktop:
        return (desktopPadding ?? padding * 2.0);
    }
  }

  /// Returns a suitable aspect ratio for child items, based on screen size
  /// and the number of columns.
  double _getAspectRatio(BxScreenSize screenSize, int columns) {
    // Adjust aspect ratio based on screen size and columns
    switch (screenSize) {
      case BxScreenSize.mobile:
        return columns <= 2 ? 1.5 : 1.2;
      case BxScreenSize.tablet:
        return columns <= 3 ? 1.8 : 1.5;
      case BxScreenSize.desktop:
        return columns <= 4 ? 2.0 : 1.8;
    }
  }
}

/// A sliver version of [ResponsiveGrid] for use inside a
/// [CustomScrollView].
///
/// It behaves exactly like [ResponsiveGrid] but renders as a sliver
/// using [SliverGrid] and [SliverPadding], making it composable with
/// other sliver widgets.
///
/// All responsive calculations (columns, spacing, padding, aspect ratio)
/// work identically to the regular grid.
class ResponsiveSliverGrid extends StatelessWidget {
  final List<Widget> children;
  final int? columns;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double spacing;
  final double? mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final EdgeInsets padding;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final double? childAspectRatio;

  const ResponsiveSliverGrid({
    super.key,
    required this.children,
    this.columns,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.spacing = 8.0,
    this.mobileSpacing,
    this.tabletSpacing,
    this.desktopSpacing,
    this.padding = EdgeInsets.zero,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);
    final orientation = BxScreenUtils.getOrientation(context);

    // Get responsive values
    final responsiveColumns = _getColumns(screenSize, orientation);
    final responsiveSpacing = _getSpacing(screenSize);
    final responsivePadding = _getPadding(screenSize);

    // Calculate cross axis count
    final crossAxisCount = columns ?? responsiveColumns;

    return SliverPadding(
      padding: responsivePadding,
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: responsiveSpacing,
          mainAxisSpacing: responsiveSpacing,
          childAspectRatio:
              childAspectRatio ?? _getAspectRatio(screenSize, crossAxisCount),
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => children[index],
          childCount: children.length,
        ),
      ),
    );
  }

  int _getColumns(BxScreenSize screenSize, Orientation orientation) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobileColumns ?? (orientation == Orientation.portrait ? 2 : 3);
      case BxScreenSize.tablet:
        return tabletColumns ?? (orientation == Orientation.portrait ? 3 : 4);
      case BxScreenSize.desktop:
        return desktopColumns ?? (orientation == Orientation.portrait ? 4 : 6);
    }
  }

  double _getSpacing(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return (mobileSpacing ?? spacing);
      case BxScreenSize.tablet:
        return (tabletSpacing ?? spacing * 1.5);
      case BxScreenSize.desktop:
        return (desktopSpacing ?? spacing * 2.0);
    }
  }

  EdgeInsets _getPadding(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return (mobilePadding ?? padding);
      case BxScreenSize.tablet:
        return (tabletPadding ?? padding * 1.5);
      case BxScreenSize.desktop:
        return (desktopPadding ?? padding * 2.0);
    }
  }

  double _getAspectRatio(BxScreenSize screenSize, int columns) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return columns <= 2 ? 1.5 : 1.2;
      case BxScreenSize.tablet:
        return columns <= 3 ? 1.8 : 1.5;
      case BxScreenSize.desktop:
        return columns <= 4 ? 2.0 : 1.8;
    }
  }
}

/// A responsive grid item that can span multiple columns depending on
/// the screen size.
///
/// It wraps the given [child] with a [Container] and applies responsive
/// padding and margin. If a span greater than 1 is specified for the
/// current screen size, the item is expanded using a
/// [FractionallySizedBox] to occupy that many columns in a grid.
///
/// The span defaults to 1 when no screen‑specific override is provided.
class ResponsiveGridItem extends StatelessWidget {
  final Widget child;
  final int? span;
  final int? mobileSpan;
  final int? tabletSpan;
  final int? desktopSpan;
  final int? watchSpan;
  final EdgeInsets? padding;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? watchPadding;
  final EdgeInsets? margin;
  final EdgeInsets? mobileMargin;
  final EdgeInsets? tabletMargin;
  final EdgeInsets? desktopMargin;
  final EdgeInsets? watchMargin;
  final Color? color;
  final Decoration? decoration;
  final Alignment? alignment;
  final Clip clipBehavior;
  final bool expand;

  const ResponsiveGridItem({
    super.key,
    required this.child,
    this.span,
    this.mobileSpan,
    this.tabletSpan,
    this.desktopSpan,
    this.watchSpan,
    this.padding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.watchPadding,
    this.margin,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.watchMargin,
    this.color,
    this.decoration,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.expand = false,
  }) : assert(
         color == null || decoration == null,
         'Cannot provide both color and decoration',
       );

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);

    // Get responsive span
    final responsiveSpan = _getSpan(screenSize);

    // Get responsive padding
    final responsivePadding = _getPadding(screenSize);

    // Get responsive margin
    final responsiveMargin = _getMargin(screenSize);

    // Build container
    Widget container = Container(
      padding: responsivePadding,
      margin: responsiveMargin,
      color: color,
      decoration: decoration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      child: expand ? SizedBox.expand(child: child) : child,
    );

    // Apply span if in grid
    if (responsiveSpan > 1) {
      container = _applySpan(container, responsiveSpan);
    }

    return container;
  }

  int _getSpan(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobileSpan ?? tabletSpan ?? desktopSpan ?? span ?? 1;
      case BxScreenSize.tablet:
        return tabletSpan ?? desktopSpan ?? span ?? 1;
      case BxScreenSize.desktop:
        return desktopSpan ?? span ?? 1;
    }
  }

  EdgeInsets _getPadding(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobilePadding ??
            tabletPadding ??
            desktopPadding ??
            padding ??
            EdgeInsets.zero;
      case BxScreenSize.tablet:
        return tabletPadding ?? desktopPadding ?? padding ?? EdgeInsets.zero;
      case BxScreenSize.desktop:
        return desktopPadding ?? padding ?? EdgeInsets.zero;
    }
  }

  EdgeInsets _getMargin(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return mobileMargin ??
            tabletMargin ??
            desktopMargin ??
            margin ??
            EdgeInsets.zero;
      case BxScreenSize.tablet:
        return tabletMargin ?? desktopMargin ?? margin ?? EdgeInsets.zero;
      case BxScreenSize.desktop:
        return desktopMargin ?? margin ?? EdgeInsets.zero;
    }
  }

  Widget _applySpan(Widget child, int span) {
    return FractionallySizedBox(widthFactor: span.toDouble(), child: child);
  }
}

/// A [ListView] that adapts the spacing between items based on the
/// current screen size.
///
/// It can be used with or without explicit separators. When `separator` is
/// `true`, a `SizedBox` with the responsive spacing is placed between
/// each pair of items. Otherwise, the items are directly built with
/// [ListView.builder].
///
/// All other [ListView] parameters are forwarded, and the responsive
/// spacing is computed similarly to the grid widgets.
class ResponsiveListView extends StatelessWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final double spacing;
  final double? mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final double? watchSpacing;
  final bool separator;

  const ResponsiveListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.spacing = 8.0,
    this.mobileSpacing,
    this.tabletSpacing,
    this.desktopSpacing,
    this.watchSpacing,
    this.separator = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = BxScreenUtils.getScreenSize(context);
    final responsiveSpacing = _getSpacing(screenSize);

    // Build list with or without separator
    if (separator && children.length > 1) {
      return ListView.separated(
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        cacheExtent: cacheExtent,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => SizedBox(
          width: scrollDirection == Axis.horizontal ? responsiveSpacing : 0,
          height: scrollDirection == Axis.vertical ? responsiveSpacing : 0,
        ),
      );
    } else {
      return ListView.builder(
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      );
    }
  }

  double _getSpacing(BxScreenSize screenSize) {
    switch (screenSize) {
      case BxScreenSize.mobile:
        return (mobileSpacing ?? spacing);
      case BxScreenSize.tablet:
        return (tabletSpacing ?? spacing * 1.5);
      case BxScreenSize.desktop:
        return (desktopSpacing ?? spacing * 2.0);
    }
  }
}
