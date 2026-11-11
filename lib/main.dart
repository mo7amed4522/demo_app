/// The entry point of the Demo App Flutter application.
///
/// This file performs the following startup sequence:
/// 1. Ensures Flutter bindings are initialized.
/// 2. Initializes time zone data (required for notification scheduling).
/// 3. Sets up a global error handler in debug mode that suppresses certain
///    keyboard assertion errors from the framework.
/// 4. Initializes Firebase and remote config via [BxFirebaseService].
/// 5. Initializes local notification plugin via [BxNotificationService].
/// 6. Sets up the dependency injection container [BxDependencyInjector].
/// 7. Launches the app inside a [ScreenUtilInit] to enable responsive UI.
///
/// File: lib/bx_main.dart
/// Architecture: Main entry point for the application
/// purpose: To initialize the application and run the AppWidget
library;

// ignore_for_file: deprecated_member_use_from_same_package

import 'package:demo_app/bx_app_widget.dart';
import 'package:demo_app/injection/bx_dependency_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Initializes all necessary services, then launches the app.
///
/// The function:
/// - Initializes time zones for scheduled notifications.
/// - Configures a silent error handler for debug-mode keyboard assertion errors.
/// - Initializes Firebase and retrieves remote config overrides.
/// - Initializes the local notification plugin.
/// - Creates the dependency injection container.
/// - Launches the [BxAppWidget] within a [ScreenUtilInit] for responsive
///   sizing.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Suppress keyboard assertion errors in debug mode
  if (kDebugMode) {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Ignore keyboard assertion errors from the framework
      if (details.exceptionAsString().contains('KeyUpEvent') ||
          details.exceptionAsString().contains('_pressedKeys.containsKey')) {
        return; // Silently ignore
      }
      // Forward other errors
      FlutterError.presentError(details);
    };
  }
  // 1. Initialize Dependency Injection
  await BxDependencyInjector.instance.setup();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BxAppWidget();
      },
    ),
  );
}
