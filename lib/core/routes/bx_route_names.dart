/// Centralised route name constants used by [BxRouteGenerator] and
/// [BxAppRouter] to navigate between screens.
///
/// All route paths follow a lower‑case, hyphen‑separated convention
/// and are grouped into [publicRoutes] and [modalRoutes] lists.
/// This class also provides utility methods to extract path parameters,
/// match patterns and obtain display names for routes.
///
/// File: lib/core/routes/bx_route_names.dart
/// Architecture: Core Routes - Bx Route Names
/// Purpose: Centralized route name constants
library;

class BxRouteNames {
  // Initial routes
  /// The splash screen route, also used as the initial route (`/`).
  static const String bxSplashScreen = '/';

  /// Login screen route.
  static const String bxLoginScreen = '/login-screen';

  /// Register screen route.
  static const String bxRegisterScreen = '/register-screen';

  /// Home screen route.
  static const String bxHomeScreen = '/home-screen';
  // BxQuickAccessScreen
  static const String bxQuickAccessScreen = '/quick-access-screen';
  //BxCongressAgendaScreen
  static const String bxCongressAgendaScreen = '/congress-agenda-screen';
  //BxSpeakersScreen
  static const String bxSpeakersScreen = '/speakers-screen';
  //BxNameTagScreen
  static const String bxNameTagScreen = '/name-tag-screen';
  //BxVenueScreen
  static const String bxVenueScreen = '/venue-screen';
  //BxLiveVotingScreen
  static const String bxLiveVotingScreen = '/live-voting-screen';
  //BxAskQaScreen
  static const String bxAskQaScreen = '/ask-qa-screen';
  //BxResourcesScreen
  static const String bxResourcesScreen = '/resources-screen';
  // Route groups
  /// All publicly accessible routes in the application.
  static const List<String> publicRoutes = [
    bxSplashScreen,
    bxLoginScreen,
    bxRegisterScreen,
    bxHomeScreen,
    bxQuickAccessScreen,
    bxCongressAgendaScreen,
    bxSpeakersScreen,
    bxNameTagScreen,
    bxVenueScreen,
    bxLiveVotingScreen,
    bxAskQaScreen,
    bxResourcesScreen,
  ];

  /// Routes that are shown as modals (currently empty).
  static const List<String> modalRoutes = [];

  /// Returns `true` if [routeName] is one of the modal routes.
  static bool isModalRoute(String routeName) {
    return modalRoutes.contains(routeName);
  }

  // Route parameter extraction

  /// Extracts a single path parameter from [routeName] based on a [pattern].
  ///
  /// The [pattern] may contain segments prefixed with `:` that represent
  /// dynamic parameters. Returns the first matching parameter value, or
  /// `null` if the route does not match the pattern.
  ///
  /// Example:
  /// ```dart
  /// extractRouteParameter('/product/42', '/product/:id'); // returns '42'
  /// ```
  static String? extractRouteParameter(String routeName, String pattern) {
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return null;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (patternParts[i].startsWith(':')) {
        // This is a parameter
        return routeParts[i];
      } else if (patternParts[i] != routeParts[i]) {
        // Path segments don't match
        return null;
      }
    }

    return null;
  }

  /// Extracts all path parameters from [routeName] using the given [pattern].
  ///
  /// Returns a map where each key is the parameter name (without the colon)
  /// and the value is the corresponding segment from the route.
  static Map<String, String> extractAllRouteParameters(
    String routeName,
    String pattern,
  ) {
    final parameters = <String, String>{};
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return parameters;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (patternParts[i].startsWith(':')) {
        // Extract parameter name (remove colon)
        final paramName = patternParts[i].substring(1);
        parameters[paramName] = routeParts[i];
      }
    }

    return parameters;
  }

  // Route matching

  /// Returns `true` if [routeName] matches the given [pattern].
  ///
  /// Segments starting with `:` in the [pattern] are treated as wildcards
  /// that match any value. All other segments must match exactly.
  static bool matchesPattern(String routeName, String pattern) {
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return false;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (!patternParts[i].startsWith(':')) {
        if (patternParts[i] != routeParts[i]) {
          return false;
        }
      }
    }

    return true;
  }

  // Get route display name

  /// Returns a human‑readable display name for the given [routeName],
  /// useful for analytics or debugging.
  static String getDisplayName(String routeName) {
    switch (routeName) {
      case bxSplashScreen:
        return 'Bx-Splash-screen';
      case bxLoginScreen:
        return 'Bx-Login-screen';
      case bxRegisterScreen:
        return 'Bx-Register-screen';
      case bxHomeScreen:
        return 'Bx-Home-screen';
      case bxQuickAccessScreen:
        return 'Bx-Quick-access-screen';
      case bxCongressAgendaScreen:
        return 'Bx-Congress-agenda-screen';
      case bxSpeakersScreen:
        return 'Bx-Speakers-screen';
      case bxNameTagScreen:
        return 'Bx-Name-tag-screen';
      case bxVenueScreen:
        return 'Bx-Venue-screen';
      case bxLiveVotingScreen:
        return 'Bx-Live-voting-screen';
      case bxAskQaScreen:
        return 'Bx-Ask-QA-screen';
      case bxResourcesScreen:
        return 'Bx-Resources-screen';
      default:
        return 'Bx-Unknown-screen';
    }
  }
}

/// Categorises a route into one of the application's routing tiers.
enum RouteCategory {
  /// Routes that do not require authentication.
  public,

  /// Routes that require the user to be authenticated.
  protected,

  /// Routes that are presented as modal overlays.
  modal,

  /// Unknown or unmatched routes.
  unknown,
}
