// File: lib/bx_app_widget.dart
// Architecture: Bx Widgets for the entire application
// purpose: To provide a single widget that can be used to render the entire application

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:demo_app/core/routes/bx_route_generator.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/core/theme/bx_app_theme.dart';
import 'package:demo_app/injection/bx_dependency_injector.dart';
import 'package:demo_app/l10n/generated/app_localizations.dart';
import 'package:demo_app/presentation/bloc/bx_localization_controller/bx_localization_controller_bloc.dart';
import 'package:demo_app/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart';
import 'package:demo_app/presentation/bloc/bx_theme_controller/bx_theme_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root widget of the application that sets up all necessary
/// [BlocProvider]s and builds the [MaterialApp] with theming,
/// localization and routing.
///
/// This widget is intended to be the top‑most widget in the widget tree
/// (e.g. passed to `runApp`). It injects the following BLoCs:
/// - [SplashScreenControllerBloc] – manages the splash screen timer and
///   APNs token registration.
/// - [BottomSideNavBarProfileControllerBloc] – handles profile‑related
///   actions and logout.
/// - [ThemeControllerBloc] – manages the app theme (light/dark/system).
/// - [LocalizationControllerBloc] – manages the app locale.
/// - [HomeScreenControllerBloc] – controls home screen state.
///
/// The [MaterialApp] is configured with:
/// * Light and dark themes from [BxAppTheme].
/// * Theme mode from [ThemeControllerBloc].
/// * Locale from [LocalizationControllerBloc].
/// * Localization delegates for generated [AppLocalizations] and the
///   standard Material, Widgets, and Cupertino localizations.
/// * Route generation via [BxRouteGenerator].
class BxAppWidget extends StatelessWidget {
  const BxAppWidget({super.key});

  /// Builds the application widget tree with multi‑bloc providers and
  /// nested [BlocBuilder]s to reactively configure the [MaterialApp].
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BxSplashScreenControllerBloc>(
          create: (context) =>
              BxSplashScreenControllerBloc()..add(const BxStartSplashTimer()),
        ),
        BlocProvider<BxThemeControllerBloc>(
          create: (context) =>
              BxThemeControllerBloc(BxDependencyInjector.instance.get())
                ..add(BxLoadThemeEvent()),
        ),
        BlocProvider<BxLocalizationControllerBloc>(
          create: (context) =>
              BxLocalizationControllerBloc(BxDependencyInjector.instance.get())
                ..add(BxLoadLocalizationEvent()),
        ),
      ],
      child: BlocBuilder<BxThemeControllerBloc, BxThemeControllerState>(
        builder: (context, themeState) {
          return BlocBuilder<
            BxLocalizationControllerBloc,
            BxLocalizationControllerState
          >(
            builder: (context, state) {
              final locale = Locale(state.languageCode);
              return BlocBuilder<
                BxSplashScreenControllerBloc,
                BxSplashScreenControllerState
              >(
                builder: (context, state) {
                  debugPrint(state.status.toString());
                  return MaterialApp(
                    title: BxAppConfiguration.bxAppName(context),
                    debugShowCheckedModeBanner: false,
                    theme: BxAppTheme.lightTheme,
                    darkTheme: BxAppTheme.darkTheme,
                    themeMode: themeState.themeMode,
                    locale: locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    initialRoute: BxRouteNames.bxSplashScreen,
                    onGenerateRoute: BxRouteGenerator.generateRoute,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
