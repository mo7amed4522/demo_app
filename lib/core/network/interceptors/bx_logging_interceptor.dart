/// Dio interceptor that logs HTTP request, response and error details
/// to the debug console via [debugPrint].
///
/// It is typically attached to a [Dio] instance in debug builds to aid
/// network debugging.  The logs are formatted with clear visual
/// separators and include method, full URL, headers, query parameters,
/// body, status code and error message.
///
/// File: lib/core/network/interceptors/bx_logging_interceptor.dart
/// Architecture: Core Layer - Bx Logging Interceptor
/// Purpose: Define the logging interceptor for the application
library;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs every HTTP request, response and error in a human‑readable
/// format using [debugPrint].
///
/// Attach this interceptor to your [Dio] instance to observe
/// network traffic:
/// ```dart
/// dio.interceptors.add(BxLoggingInterceptor());
/// ```
class BxLoggingInterceptor extends Interceptor {
  /// Logs the outgoing request before it is sent.
  ///
  /// Outputs the HTTP method, full URL (base URL + path), query
  /// parameters, headers and request body (if any).  After logging,
  /// the request continues normally via [handler.next].
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final fullUrl = '${options.baseUrl}${options.path}';
    debugPrint('\n┏━━━ REQUEST ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('┃ Method  : ${options.method}');
    debugPrint('┃ URL     : $fullUrl');
    debugPrint('┃ Base URL: ${options.baseUrl} [AppConfig / Firebase RC]');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('┃ Params  : ${options.queryParameters}');
    }
    if (options.headers.isNotEmpty) {
      debugPrint('┃ Headers : ${options.headers}');
    }
    if (options.data != null) {
      debugPrint('┃ Body    : ${options.data}');
    }
    debugPrint('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(options);
  }

  /// Logs a successful HTTP response.
  ///
  /// Prints the HTTP status code, full URL and the response data.
  /// After logging, the response is passed to the next interceptor
  /// (or the calling code) via [handler.next].
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final fullUrl = '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    debugPrint('\n┏━━━ RESPONSE ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('┃ Status  : ${response.statusCode}');
    debugPrint('┃ URL     : $fullUrl');
    debugPrint('┃ Data    : ${response.data}');
    debugPrint('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(response);
  }

  /// Logs an error that occurred during the HTTP request/response cycle.
  ///
  /// Displays the HTTP status code (if the server responded), full URL
  /// and the error message from the [DioException].  The error is then
  /// forwarded so it can be handled by other interceptors or error
  /// handlers.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final fullUrl = '${err.requestOptions.baseUrl}${err.requestOptions.path}';
    debugPrint('\n┏━━━ ERROR ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('┃ Status  : ${err.response?.statusCode}');
    debugPrint('┃ URL     : $fullUrl');
    debugPrint('┃ Message : ${err.message}');
    debugPrint('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    handler.next(err);
  }
}
