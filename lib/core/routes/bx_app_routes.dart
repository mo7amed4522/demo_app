/// Centralised application router providing static navigation helpers,
/// deep link handling, custom transition builders, modal dialogs and
/// a [RouterConfig] for use with `MaterialApp.router`.
///
/// [BxAppRouter] wraps the [Navigator] API and the application's
/// [BxRouteGenerator] to offer a consistent, type‑safe way to navigate.
/// It also includes utilities for analytics logging, route argument
/// extraction and back‑button confirmation.
///
/// For declarative navigation with `MaterialApp.router`, call
/// [createRouterConfig] to obtain a ready‑to‑use [RouterConfig].
///
/// File: lib/core/routes/bx_app_router.dart
/// Architecture: Core Routes - Bx App Router
/// Purpose: Main application router configuration
library;

// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:demo_app/core/routes/bx_route_generator.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:flutter/material.dart';

/// The application's main router, implemented as a singleton.
///
/// Provides static convenience methods for common navigation tasks:
/// - [push], [pushReplacement], [pushAndPopUntil], [pop]
/// - Deep link handling via [handleDeepLink]
/// - Custom page transitions ([fadeTransitionBuilder], [slideTransitionBuilder])
/// - Modal bottom sheets and dialogs ([showModal], [showDialogModal])
/// - Router configuration for `MaterialApp.router` ([createRouterConfig])
///
/// All navigation methods operate on a given [BuildContext] and use the
/// named route strings defined in [BxRouteNames].
class BxAppRouter {
  // Singleton instance
  static final BxAppRouter _instance = BxAppRouter._internal();

  /// Returns the singleton instance of [BxAppRouter].
  factory BxAppRouter() => _instance;

  BxAppRouter._internal();

  // Navigation methods using BxRouteGenerator

  /// Pushes a named route onto the navigator stack.
  ///
  /// Delegates to [BxRouteGenerator.pushNamed] which handles route
  /// generation and analytics logging.
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    OnNavigationFailure? onFailure,
  }) {
    return BxRouteGenerator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a new named route.
  ///
  /// The previous route is removed from the stack.
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
    OnNavigationFailure? onFailure,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Pushes a named route and removes all previous routes that do not
  /// satisfy the given [predicate].
  ///
  /// Commonly used to clear the navigation stack after login.
  static Future<T?> pushAndPopUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    required RoutePredicate predicate,
    Object? arguments,
    OnNavigationFailure? onFailure,
  }) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);
  }

  /// Pops the current route off the navigator stack, optionally returning
  /// a [result] to the previous route.
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  /// Returns `true` if the navigator can pop a route.
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  /// Tries to pop the current route, returning `true` if successful.
  ///
  /// Unlike [pop], this will not throw if there is nothing to pop.
  static Future<bool> maybePop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) async {
    return await Navigator.of(context).maybePop(result);
  }

  // Route information

  /// Returns the name (path) of the current route.
  static String getCurrentPath(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    return routeSettings?.name ?? '';
  }

  /// Alias for [getCurrentPath].
  static String getCurrentName(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    return routeSettings?.name ?? '';
  }

  // Deep link handling

  /// Handles an incoming deep link string, parsing it and navigating
  /// to the appropriate screen.
  ///
  /// Supports product, user and generic route patterns. Falls back to the
  /// login screen if the link cannot be recognised.
  static Future<void> handleDeepLink(
    BuildContext context,
    String link, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final uri = Uri.parse(link);
      final path = uri.path;
      final queryParams = uri.queryParameters;

      // Handle different deep link patterns
      if (path.startsWith('/product/')) {
        final productId = path.split('/').last;
        await _handleProductDeepLink(context, productId, queryParams);
      } else if (path.startsWith('/user/')) {
        final userId = path.split('/').last;
        await _handleUserDeepLink(context, userId, queryParams);
      } else {
        // Try to navigate using the path
        if (BxRouteGenerator.isValidRoute(path)) {
          await push(context, path);
        } else {
          await push(context, BxRouteNames.bxLoginScreen);
        }
      }
    } catch (e) {
      // Navigate to error page
      await push(context, BxRouteNames.bxLoginScreen);
    }
  }

  /// Placeholder handler for deep links targeting a product.
  ///
  /// Currently only logs the product id and query parameters. Implement
  /// actual navigation logic when product detail routes are available.
  static Future<void> _handleProductDeepLink(
    BuildContext context,
    String productId,
    Map<String, String> queryParams,
  ) async {
    // await push(context, RouteConstants.buildProductDetailRoute(productId));
    debugPrint('Product deep link: $productId, params: $queryParams');
  }

  /// Placeholder handler for deep links targeting a user profile.
  ///
  /// Currently only logs the user id and query parameters.
  static Future<void> _handleUserDeepLink(
    BuildContext context,
    String userId,
    Map<String, String> queryParams,
  ) async {
    // await push(context, RouteConstants.buildUserDetailRoute(userId));
    debugPrint('User deep link: $userId, params: $queryParams');
  }

  // Route builder for custom transitions

  /// Creates a [Route] that fades in the given [child] over 300 ms.
  ///
  /// Useful for screens that should appear softly, such as a splash
  /// or a modal overlay.
  static Route<T> fadeTransitionBuilder<T>(
    BuildContext context,
    Widget child,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Creates a [Route] that slides the given [child] in from the right
  /// over 300 ms.
  ///
  /// Mimics the default platform transition for pushing a new screen.
  static Route<T> slideTransitionBuilder<T>(
    BuildContext context,
    Widget child,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Route logging for analytics

  /// Logs a route change event to the debug console (and potentially to
  /// an analytics service).
  ///
  /// Call this from navigation observers or route‑aware widgets to track
  /// user navigation.
  static void logRouteChange(
    String previousRoute,
    String newRoute,
    Map<String, dynamic>? parameters,
  ) {
    // Integrate with your analytics service
    debugPrint('Route changed: $previousRoute -> $newRoute');
    if (parameters != null && parameters.isNotEmpty) {
      debugPrint('Parameters: $parameters');
    }
  }

  // Clear navigation stack

  /// Clears the entire navigation stack and pushes [routeName] as the
  /// only route.
  ///
  /// Equivalent to `pushAndPopUntil` with a predicate that always returns
  /// `false`.
  static void clearStackAndNavigate(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // Check if current route is in stack

  /// Returns `true` if the current topmost route matches [routeName].
  static bool isRouteInStack(BuildContext context, String routeName) {
    return ModalRoute.of(context)?.settings.name == routeName;
  }

  // Get route arguments

  /// Retrieves the arguments passed to the current route, or `null`.
  static Object? getRouteArguments(BuildContext context) {
    final route = ModalRoute.of(context);
    return route?.settings.arguments;
  }

  // Modal navigation

  /// Shows a modal bottom sheet containing [widget].
  ///
  /// The sheet is scroll‑controlled and can be customised with
  /// [isDismissible], [enableDrag] and [barrierColor].
  static Future<T?> showModal<T>(
    BuildContext context,
    Widget widget, {
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
    String? routeName,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => widget,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: barrierColor,
      isScrollControlled: true,
      routeSettings: routeName != null ? RouteSettings(name: routeName) : null,
    );
  }

  /// Shows a dialog using [showDialog], with the given [widget] as content.
  ///
  /// Supports barrier dismissal and a custom [barrierColor].
  static Future<T?> showDialogModal<T>(
    BuildContext context,
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    String? routeName,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => widget,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      routeSettings: routeName != null ? RouteSettings(name: routeName) : null,
    );
  }

  // Back button handler

  /// Handles the Android back button press.
  ///
  /// If the navigator can pop, it pops normally. Otherwise, shows an
  /// exit confirmation dialog. Returns `true` if the app should exit.
  static Future<bool> onWillPop(BuildContext context, {String? message}) async {
    if (canPop(context)) {
      pop(context);
      return false;
    }

    // Show confirmation dialog
    final shouldPop = await showDialogModal<bool>(
      context,
      AlertDialog(
        title: const Text('Exit App'),
        content: Text(message ?? 'Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => pop(context, true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  /// Constructs a [RouterConfig] suitable for `MaterialApp.router`.
  ///
  /// The returned config uses a custom [RouteInformationParser] and
  /// [RouterDelegate] to integrate with [BxRouteGenerator].
  ///
  /// Usage:
  /// ```dart
  /// MaterialApp.router(
  ///   routerConfig: BxAppRouter.createRouterConfig(),
  ///   ...
  /// );
  /// ```
  static RouterConfig<Object> createRouterConfig() {
    return RouterConfig(
      routeInformationParser: _AppRouteInformationParser(),
      routerDelegate: _BxAppRouterDelegate(),
    );
  }
}

// Private route information parser

/// Parses a [RouteInformation] into a plain string representing the route path.
///
/// This simple implementation just passes the URI location string through.
class _AppRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return routeInformation.location;
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

// Private router delegate

/// Custom [RouterDelegate] that builds a [Navigator] using the
/// [BxRouteGenerator] to resolve routes.
///
/// It listens for configuration changes via [setNewRoutePath] and
/// provides the navigator key for programmatic control.
class _BxAppRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  String? _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    // Use the BxRouteGenerator to generate routes
    final route = BxRouteGenerator.generateRoute(
      RouteSettings(name: _currentConfiguration),
    );

    // Return a Navigator with the generated route
    return Navigator(
      key: navigatorKey,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [route];
      },
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _currentConfiguration = configuration;
    notifyListeners();
  }

  @override
  String? get currentConfiguration => _currentConfiguration;

  /// The navigator key used by the delegate.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<bool> popRoute() async {
    // Implement pop functionality
    return false;
  }
}

/// Signature for a callback that reports a navigation failure.
///
/// [routeName] is the name of the route that failed, and [error] is the
/// exception that caused the failure.
typedef OnNavigationFailure = void Function(String routeName, Object error);
