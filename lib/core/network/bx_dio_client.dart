/// Singleton [Dio] HTTP client wrapper that provides a centralised way to
/// perform network requests (GET, POST, PUT, PATCH, DELETE) with automatic
/// error handling, authentication interceptor and logging.
///
/// It uses a [Dio] instance configured with the base URL from [BxApiEndpoints],
/// timeouts and a custom `validateStatus` that accepts any status ≤ 500.
/// Responses with status codes 200–299 are returned directly; other codes
/// and connection errors are converted to [BxNetworkException] instances.
/// HTML error pages (e.g. from a proxy or server misconfiguration) are parsed
/// to extract a human‑readable message.
///
/// File: lib/core/network/bx_dio_client.dart
library;

import 'package:demo_app/core/network/bx_api_endpoints.dart';
import 'package:demo_app/core/network/interceptors/bx_auth_interceptor.dart';
import 'package:demo_app/core/network/interceptors/bx_error_interceptor.dart';
import 'package:demo_app/core/network/interceptors/bx_logging_interceptor.dart';
import 'package:demo_app/core/network/interceptors/bx_network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// The application's sole HTTP client, accessible via [BxDioClient.instance].
///
/// Configures a [Dio] instance with:
/// - Base URL from [BxApiEndpoints.baseUrl]
/// - 30‑second connect and receive timeouts
/// - A `validateStatus` that keeps all responses with status ≤ 500,
///   allowing manual inspection and custom error handling.
/// - Three interceptors: [BxAuthInterceptor] (attaches auth tokens),
///   [BxErrorInterceptor], and [BxLoggingInterceptor] (debug logging).
///
/// All HTTP methods (`get`, `post`, `put`, `patch`, `delete`) catch
/// [DioException] and general exceptions, converting them to
/// [BxNetworkException] and parsing HTML error pages if needed.
class BxDioClient {
  late final Dio _dio;

  /// Internal [Dio] instance used for all requests.
  static final BxDioClient _instance = BxDioClient._internal();

  /// Returns the singleton instance of [BxDioClient].
  static BxDioClient get instance => _instance;

  /// Private constructor that initialises [Dio] and adds interceptors.
  BxDioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BxApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        // Accept ALL status codes - we'll handle errors manually
        validateStatus: (status) => status != null && status <= 500,
      ),
    );

    _dio.interceptors.addAll([
      BxAuthInterceptor(),
      BxErrorInterceptor(),
      BxLoggingInterceptor(),
    ]);
  }

  // GET

  /// Sends an HTTP GET request to [path].
  ///
  /// Optional [queryParameters], [options], [cancelToken] and
  /// [onReceiveProgress] are passed directly to [Dio.get].
  /// Returns the parsed response data (typically a `Map` or `List`)
  /// on success (status 200–299), or throws [BxNetworkException] on failure.
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw BxNetworkException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
        type: DioExceptionType.unknown,
      );
    }
    return _processResponse(response);
  }

  // POST

  /// Sends an HTTP POST request to [path] with an optional [data] body.
  ///
  /// Supports [queryParameters], [options], [cancelToken],
  /// [onSendProgress] and [onReceiveProgress].
  /// Returns the parsed response on success; otherwise throws
  /// [BxNetworkException].
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw BxNetworkException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
        type: DioExceptionType.unknown,
      );
    }
    return _processResponse(response);
  }

  // PUT

  /// Sends an HTTP PUT request to [path] with an optional [data] body.
  ///
  /// Other parameters behave like [post]. Returns parsed data or throws.
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw BxNetworkException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
        type: DioExceptionType.unknown,
      );
    }
    return _processResponse(response);
  }

  // PATCH

  /// Sends an HTTP PATCH request to [path] with an optional [data] body.
  ///
  /// Other parameters behave like [post]. Returns parsed data or throws.
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response response;
    try {
      response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw BxNetworkException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
        type: DioExceptionType.unknown,
      );
    }
    return _processResponse(response);
  }

  // DELETE

  /// Sends an HTTP DELETE request to [path].
  ///
  /// Supports an optional [data] body, [queryParameters], [options] and
  /// [cancelToken]. Returns parsed data or throws [BxNetworkException].
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw BxNetworkException(
        message: 'Network error: ${e.toString()}',
        statusCode: 0,
        type: DioExceptionType.unknown,
      );
    }
    return _processResponse(response);
  }

  /// Inspects the HTTP [response] and returns its data if the status code
  /// indicates success (200–299).  Otherwise, it may attempt to extract
  /// additional error information from HTML or JSON content (currently only
  /// logs or does nothing, leaving error handling to the caller interceptor).
  ///
  /// This method is a placeholder for future response validation logic.
  dynamic _processResponse(Response response) {
    final statusCode = response.statusCode;
    final data = response.data;

    debugPrint('📥 Response Status: $statusCode');

    // Success case - return data directly
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return data;
    }

    // Check for HTML error response
    if (data is String && data.trim().startsWith('<!DOCTYPE', 0)) {
      // HTML error – parsing is done later in _handleDioError for badResponse
    }
    // Check for JSON error response
    else if (data is Map<String, dynamic>) {
      // JSON error – could extract message here
    }
    // Other cases
    else {
      // Unknown format
    }
  }

  /// Converts a [DioException] into a [BxNetworkException] with a
  /// human‑readable message based on the error type, status code and
  /// response body (HTML or JSON).
  ///
  /// The resulting exception preserves the original [DioExceptionType],
  /// status code and response data, making it easier to handle downstream.
  BxNetworkException _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    debugPrint('❌ DioError: ${error.type}');
    debugPrint('❌ Status: $statusCode');

    String message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timed out. Please try again.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timed out. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Server took too long to respond. Please try again.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badResponse:
        if (data is String && data.trim().startsWith('<!DOCTYPE', 0)) {
          message = _parseHtmlError(data, statusCode);
        } else if (data is Map<String, dynamic>) {
          message =
              data['message'] as String? ??
              data['error'] as String? ??
              'Server error occurred';
        } else {
          message = 'Server error (HTTP $statusCode)';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      default:
        message = error.message ?? 'An unexpected error occurred';
    }

    return BxNetworkException(
      message: message,
      statusCode: statusCode ?? 0,
      type: error.type,
      data: data,
    );
  }

  /// Attempts to extract a human‑readable error message from an HTML string
  /// returned by the server (e.g. a proxy error page).
  ///
  /// Searches for `<title>`, `<h1>` and `<p>` tags, falling back to a
  /// status‑code‑based default message if nothing is found.
  String _parseHtmlError(String html, int? statusCode) {
    // Extract title from HTML
    final titleMatch = RegExp(
      r'<title>(.*?)</title>',
      caseSensitive: false,
    ).firstMatch(html);
    final headingMatch = RegExp(
      r'<h1>(.*?)</h1>',
      caseSensitive: false,
    ).firstMatch(html);
    final paragraphMatch = RegExp(
      r'<p>(.*?)</p>',
      caseSensitive: false,
    ).firstMatch(html);

    if (paragraphMatch != null) {
      return paragraphMatch.group(1) ?? 'Server error occurred';
    }

    if (headingMatch != null) {
      return headingMatch.group(1) ?? 'Server error occurred';
    }

    if (titleMatch != null) {
      return titleMatch.group(1) ?? 'Server error occurred';
    }

    // Fallback based on status code
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please check your credentials.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Internal server error. Please try again.';
      default:
        return 'Server error (HTTP $statusCode)';
    }
  }
}
