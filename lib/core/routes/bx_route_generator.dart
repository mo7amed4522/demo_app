/// Generates application routes from [RouteSettings] and provides
/// static helpers for navigation, deep linking, analytics and route
/// metadata (title and icon).
///
/// All routes returned by [generateRoute] use a slide‑up transition
/// unless overridden by the dedicated builders:
/// - [fadeTransitionRoute] – fade in
/// - [slideTransitionRoute] – slide from right
/// - [scaleTransitionRoute] – scale up
///
/// File: lib/core/routes/bx_route_generator.dart
/// Architecture: Core Routes - Bx Route Generator
/// Purpose: Custom route generation and navigation
library;

import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/presentation/views/bx_ask_qa_screen/bx_ask_qa_screen.dart';
import 'package:demo_app/presentation/views/bx_congress_agenda_screen/bx_congress_agenda_screen.dart';
import 'package:demo_app/presentation/views/bx_home_screen/bx_home_screen.dart';
import 'package:demo_app/presentation/views/bx_live_voting_screen/bx_live_voting_screen.dart';
import 'package:demo_app/presentation/views/bx_login_screen/bx_login_screen.dart';
import 'package:demo_app/presentation/views/bx_name_tag_screen/bx_name_tag_screen.dart';
import 'package:demo_app/presentation/views/bx_quick_access_screen/bx_quick_access_screen.dart';
import 'package:demo_app/presentation/views/bx_register_screen/bx_register_screen.dart';
import 'package:demo_app/presentation/views/bx_resources_screen/bx_resources_screen.dart';
import 'package:demo_app/presentation/views/bx_speakers_screen/bx_speakers_screen.dart';
import 'package:demo_app/presentation/views/bx_splash_screen/bx_splash_screen.dart';
import 'package:demo_app/presentation/views/bx_venue_screen/bx_venue_screen.dart';
import 'package:flutter/material.dart';

/// Central route generator that maps route names to screens and
/// provides reusable transition builders and navigation utilities.
///
/// Call [generateRoute] to obtain a [Route] for a given [RouteSettings].
/// The returned route already includes a slide‑up transition and logs the
/// navigation event via [trackRouteView].
class BxRouteGenerator {
  /// Maps a [RouteSettings] name to a concrete page widget wrapped
  /// in a [PageRouteBuilder] with a slide‑up transition.
  ///
  /// Unrecognised routes fall back to [LoginScreen].
  /// Before building the route, the navigation is logged for analytics.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Track route for analytics
    BxRouteGenerator.trackRouteView(
      settings.name ?? '',
      parameters: {'arguments': settings.arguments},
    );

    switch (settings.name) {
      // Public routes
      case BxRouteNames.bxSplashScreen:
        return _buildRoute(settings, const BxSplashScreen());
      case BxRouteNames.bxLoginScreen:
        return _buildRoute(settings, const BxLoginPage());
      case BxRouteNames.bxRegisterScreen:
        return _buildRoute(settings, const BxRegisterPage());
      case BxRouteNames.bxHomeScreen:
        return _buildRoute(settings, const BxHomeScreen());
      case BxRouteNames.bxQuickAccessScreen:
        return _buildRoute(settings, const BxQuickAccessScreen());
      case BxRouteNames.bxCongressAgendaScreen:
        return _buildRoute(settings, const BxCongressAgendaScreen());
      case BxRouteNames.bxSpeakersScreen:
        return _buildRoute(settings, const BxSpeakersScreen());
      case BxRouteNames.bxNameTagScreen:
        return _buildRoute(settings, const BxNameTagScreen());
      case BxRouteNames.bxVenueScreen:
        return _buildRoute(settings, const BxVenueScreen());
      case BxRouteNames.bxLiveVotingScreen:
        return _buildRoute(settings, const BxLiveVotingScreen());
      case BxRouteNames.bxAskQaScreen:
        return _buildRoute(settings, const BxAskQaScreen());
      case BxRouteNames.bxResourcesScreen:
        return _buildRoute(settings, const BxResourcesScreen());
      // Default route (404)
      default:
        return _buildRoute(settings, const BxLoginPage());
    }
  }

  /// Internal helper that wraps [page] in a [PageRouteBuilder] with a
  /// slide‑up (from bottom) transition lasting 300 ms.
  static Route<dynamic> _buildRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Custom transition routes

  /// Builds a route that fades in the given [page] over 300 ms.
  ///
  /// Optionally attach [settings] for analytics and argument passing.
  static Route<dynamic> fadeTransitionRoute(
    Widget page, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Builds a route that slides [page] in from the right over 300 ms.
  ///
  /// Similar to the default platform push transition.
  static Route<dynamic> slideTransitionRoute(
    Widget page, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Builds a route that scales [page] up from 0 to 1 over 400 ms
  /// using a `fastOutSlowIn` curve.
  static Route<dynamic> scaleTransitionRoute(
    Widget page, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  // Navigation helpers

  /// Replaces the current route with a named route.
  static void pushReplacementNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pushes a named route onto the navigator and returns a [Future]
  /// that completes when the route is popped.
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Pops routes until a route with the given [routeName] is reached.
  static void popUntilNamed(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  /// Pops the current route and immediately pushes a named route.
  static void popAndPushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).popAndPushNamed(routeName, arguments: arguments);
  }

  /// Pushes a named route and removes all routes that do not satisfy
  /// the [predicate].
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(
      context,
    ).pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
  }

  // Deep linking

  /// Returns `true` if the given [url] is a deep link supported by the app.
  ///
  /// A deep link can start with `https://`, `http://`, or the custom scheme
  /// `myapp://`.
  static bool isDeepLink(String url) {
    return url.startsWith('https://') ||
        url.startsWith('http://') ||
        url.startsWith('myapp://');
  }

  /// Parses a deep link [url] and returns a map of its components:
  /// - `'path'`: the path segments as a list of strings
  /// - All query parameters
  /// - `'fragment'` if present
  static Map<String, dynamic> parseDeepLinkParameters(String url) {
    final uri = Uri.parse(url);
    final params = <String, dynamic>{};

    // Extract path segments
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      params['path'] = pathSegments;
    }

    // Extract query parameters
    params.addAll(uri.queryParameters);

    // Extract fragment
    if (uri.fragment.isNotEmpty) {
      params['fragment'] = uri.fragment;
    }

    return params;
  }

  /// Creates a deep link string using the custom scheme `myapp://` and the
  /// given [path].  Optional [parameters] are encoded as query parameters,
  /// and an optional [fragment] is appended.
  static String generateDeepLink({
    required String path,
    Map<String, dynamic>? parameters,
    String? fragment,
  }) {
    final buffer = StringBuffer('myapp://$path');

    if (parameters != null && parameters.isNotEmpty) {
      final queryParams = parameters.entries
          .where((entry) => entry.value != null)
          .map(
            (entry) =>
                '${entry.key}=${Uri.encodeComponent(entry.value.toString())}',
          )
          .join('&');

      if (queryParams.isNotEmpty) {
        buffer.write('?$queryParams');
      }
    }

    if (fragment != null && fragment.isNotEmpty) {
      buffer.write('#${Uri.encodeComponent(fragment)}');
    }

    return buffer.toString();
  }

  // Route analytics

  /// Logs a route view event to the debug console.
  ///
  /// In production, this should be replaced by an analytics service call.
  static void trackRouteView(
    String routeName, {
    Map<String, dynamic>? parameters,
  }) {
    // Integrate with analytics service
    // Example: AnalyticsService.trackScreenView(routeName, parameters);

    debugPrint('Route viewed: $routeName');
    if (parameters != null) {
      debugPrint('Route parameters: $parameters');
    }
  }

  // Route validation

  /// Returns `true` if [routeName] is one of the predefined app routes or
  /// matches the product/user deep link pattern.
  static bool isValidRoute(String routeName) {
    final validRoutes = [
      BxRouteNames.bxSplashScreen,
      BxRouteNames.bxLoginScreen,
      BxRouteNames.bxRegisterScreen,
      BxRouteNames.bxHomeScreen,
      BxRouteNames.bxQuickAccessScreen,
      BxRouteNames.bxCongressAgendaScreen,
      BxRouteNames.bxSpeakersScreen,
      BxRouteNames.bxNameTagScreen,
      BxRouteNames.bxVenueScreen,
      BxRouteNames.bxLiveVotingScreen,
      BxRouteNames.bxAskQaScreen,
      BxRouteNames.bxResourcesScreen,
    ];

    return validRoutes.contains(routeName) ||
        routeName.startsWith('/product/') ||
        routeName.startsWith('/user/');
  }

  // Get route title for display

  /// Returns a human‑readable string identifier for the given [routeName],
  /// or `'App'` for unknown routes.
  static String getRouteTitle(String routeName) {
    switch (routeName) {
      case BxRouteNames.bxSplashScreen:
        return 'Bx-Splash-screen';
      case BxRouteNames.bxLoginScreen:
        return 'Bx-Login-screen';
      case BxRouteNames.bxRegisterScreen:
        return 'Bx-Register-screen';
      case BxRouteNames.bxHomeScreen:
        return 'Bx-Home-screen';
      case BxRouteNames.bxQuickAccessScreen:
        return 'Bx-Quick-access-screen';
      case BxRouteNames.bxCongressAgendaScreen:
        return 'Bx-Congress-agenda-screen';
      case BxRouteNames.bxSpeakersScreen:
        return 'Bx-Speakers-screen';
      case BxRouteNames.bxNameTagScreen:
        return 'Bx-Name-tag-screen';
      case BxRouteNames.bxVenueScreen:
        return 'Bx-Venue-screen';
      case BxRouteNames.bxLiveVotingScreen:
        return 'Bx-Live-voting-screen';
      case BxRouteNames.bxAskQaScreen:
        return 'Bx-Ask-QA-screen';
      case BxRouteNames.bxResourcesScreen:
        return 'Bx-Resources-screen';
      default:
        return 'App';
    }
  }

  /// Returns an appropriate [IconData] for the given [routeName],
  /// or `null` if no icon is defined.
  static IconData? getRouteIcon(String routeName) {
    switch (routeName) {
      case BxRouteNames.bxSplashScreen:
        return Icons.splitscreen;
      case BxRouteNames.bxLoginScreen:
        return Icons.login;
      case BxRouteNames.bxRegisterScreen:
        return Icons.app_registration;
      case BxRouteNames.bxHomeScreen:
        return Icons.home;
      case BxRouteNames.bxQuickAccessScreen:
        return Icons.flash_on;
      case BxRouteNames.bxCongressAgendaScreen:
        return Icons.event;
      case BxRouteNames.bxSpeakersScreen:
        return Icons.record_voice_over;
      case BxRouteNames.bxNameTagScreen:
        return Icons.badge;
      case BxRouteNames.bxVenueScreen:
        return Icons.location_on;
      case BxRouteNames.bxLiveVotingScreen:
        return Icons.how_to_vote;
      case BxRouteNames.bxAskQaScreen:
        return Icons.question_answer;
      case BxRouteNames.bxResourcesScreen:
        return Icons.folder;
      default:
        return null;
    }
  }
}
