// File: lib/core/network/interceptors/bx_auth_interceptor.dart
// Architecture: Core Layer - Bx Auth Interceptor
// Purpose: Define the auth interceptor for the application

import 'package:dio/dio.dart';

class BxAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token if available
    // final token = Storage.getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    handler.next(options);
  }
}
