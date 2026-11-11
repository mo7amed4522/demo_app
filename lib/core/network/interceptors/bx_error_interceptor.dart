// File: lib/core/network/interceptors/bx_auth_interceptor.dart
// Architecture: Core Layer - Bx Auth Interceptor
// Purpose: Define the auth interceptor for the application

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BxErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle global errors like 401 Unauthorized
    if (err.response?.statusCode == 401) {
      debugPrint("error is ");
    }
    handler.next(err);
  }
}
