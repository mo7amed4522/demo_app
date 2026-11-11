// File: lib/core/network/exceptions/bx_network_exception.dart

import 'package:dio/dio.dart';

class BxNetworkException implements Exception {
  final String message;
  final int statusCode;
  final DioExceptionType type;
  final dynamic data;

  BxNetworkException({required this.message, required this.statusCode, required this.type, this.data});

  @override
  String toString() => 'BxNetworkException: $message (Status: $statusCode)';
}
