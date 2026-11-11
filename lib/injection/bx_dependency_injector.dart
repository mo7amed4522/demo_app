// File: lib/injection/bx_dependency_injector.dart
// Architecture: Dependency Injection - Main Injector
// Pattern: Dependency injection setup for the entire app

import 'package:demo_app/core/network/bx_dio_client.dart';
import 'package:demo_app/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:demo_app/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Central dependency injection container based on [GetIt].
///
/// This singleton initialises and wires together all core services,
/// data sources, repositories and use cases. The [setup] method must
/// be called once during app startup (e.g. in `main()` or a splash
/// screen) to register all dependencies before any other part of the
/// application attempts to retrieve them via the [get] method.
///
/// Usage:
/// ```dart
/// final injector = BxDependencyInjector.instance;
/// await injector.setup();
/// // later…
/// final loginUsecase = injector.get<BxLoginUserUsecase>();
/// ```
class BxDependencyInjector {
  static final BxDependencyInjector _singleton =
      BxDependencyInjector._internal();
  static final GetIt _getIt = GetIt.instance;

  /// Returns the singleton instance of the injector.
  factory BxDependencyInjector() {
    return _singleton;
  }

  BxDependencyInjector._internal();

  /// Provides access to the singleton from anywhere.
  static BxDependencyInjector get instance => _singleton;

  /// Registers all application dependencies.
  ///
  /// Must be called once before the first [get] call. It initialises:
  /// - Core: [BxDioClient] (singleton HTTP client)
  /// - SharedPreferences (singleton, obtained asynchronously)
  /// - Remote data source ([BxSystemRemoteDataSource])
  /// - Local data source ([BxSharedPreferencesDataSource])
  /// - All domain repositories (each bound to their implementation)
  /// - All use cases, with their required repositories injected
  ///
  /// After this completes, any registered type can be retrieved via [get].
  Future<void> setup() async {
    // Core
    _getIt.registerLazySingleton<BxDioClient>(() => BxDioClient.instance);

    // Initialize SharedPreferences first
    final sharedPreferences = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // Data Sources
    _getIt.registerLazySingleton<BxSystemRemoteDataSource>(
      () => BxSystemRemoteDataSourceImpl(dioClient: _getIt()),
    );
    _getIt.registerLazySingleton<BxSharedPreferencesDataSource>(
      () => BxSharedPreferencesDataSourceImpl(_getIt()),
    );

    // Repositories

    // UseCases
  }

  /// Retrieves a previously registered dependency of type [T].
  ///
  /// Throws a [GetIt] error if the type has not been registered.
  T get<T extends Object>() => _getIt.get<T>();
}
