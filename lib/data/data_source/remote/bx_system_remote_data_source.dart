// File: lib/core/data/data_sources/remote/bx_system_remote_data_source.dart
// Architecture: Core -> Data -> Data Sources -> Remote -> Bx System Remote Data Source - Error Handler
// Purpose: Centralized error handling and logging for system-related remote data source operations

// ignore_for_file: prefer_initializing_formals, unused_field

import 'package:demo_app/core/network/bx_dio_client.dart';

/// Defines the contract for remote API calls related to the core system
/// functionalities: authentication, services, reservations, doctors,
/// specialties, FAQs, reviews, leads, and push token registration.
///
/// Every method returns a response object *without throwing exceptions*;
/// network and server errors are captured inside the response model's
/// status/code fields, allowing callers to handle errors uniformly.
abstract class BxSystemRemoteDataSource {}

/// Concrete implementation of [BxSystemRemoteDataSource] that uses
/// [BxDioClient] for HTTP communication.
///
/// Each method follows a consistent error‑handling pattern:
/// - On a successful 200 response the corresponding success model is
///   returned (populated from JSON).
/// - If the raw response is a [String], it attempts to decode it as JSON.
/// - If a [BxNetworkException] occurs, an error response model with the
///   exception's status code and message is returned.
/// - Any other exception is caught and translated into a generic error
///   response model with a 500 status code.
///
/// This design ensures that callers never receive uncaught exceptions and
/// can inspect the response object's `status` or `code` to determine
/// success or failure.
class BxSystemRemoteDataSourceImpl implements BxSystemRemoteDataSource {
  final BxDioClient _dioClient;

  BxSystemRemoteDataSourceImpl({required BxDioClient dioClient})
    : _dioClient = dioClient;
}
