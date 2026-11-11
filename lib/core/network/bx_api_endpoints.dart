/// Centralised definition of the application's base URL and all REST API
/// endpoint paths.
///
/// All endpoints are relative to the base URL defined in [BxAppConfig].
/// The classes are non‑instantiable and designed to be used statically
/// throughout the application, avoiding hard‑coded URL strings.
///
/// File: lib/core/network/bx_api_endpoints.dart
/// Architecture: Core Layer - Bx API Endpoints
/// Purpose: Define the API endpoints for the application
class BxAppConfig {
  /// The Test URL of the backend API (staging environment).
  static const String baseUrl = 'http://localhost:/'; // Base URL for the API, can be switched to production when needed
}

/// Provides static getters for every API endpoint used by the application.
///
/// All paths are relative to [BxAppConfig.baseUrl].  Methods that require
/// path or query parameters accept them as arguments and return the fully
/// assembled relative URL.
///
/// This class cannot be instantiated.
class BxApiEndpoints {
  BxApiEndpoints._();

  /// Convenience getter that returns the same value as [BxAppConfig.baseUrl].
  static String get baseUrl => BxAppConfig.baseUrl;
}
