// File: lib/presentation/views/bx_splash_screen/bx_splash_screen.dart
// Architecture: Presentation Layer - Bx Splash Screen
// Purpose: Main bx splash screen that delegates to mobile/tablet widgets

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_splash_widget/bx_splash_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_splash_widget/bx_splash_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxSplashScreen extends StatelessWidget {
  const BxSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BxSplashScreenControllerBloc()..add(const BxStartSplashTimer()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body:
            BlocListener<
              BxSplashScreenControllerBloc,
              BxSplashScreenControllerState
            >(
              listener: (context, state) {
                if (state.status == BxSplashScreenStatus.success) {
                  BxAppRouter.pushReplacement(
                    context,
                    BxRouteNames.bxLoginScreen,
                  );
                } else if (state.status == BxSplashScreenStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'An error occurred'),
                    ),
                  );
                }
              },
              child: BxResponsiveBuilder(
                mobileBuilder: (context) => const BxSplashWidgetMobile(),
                tabletBuilder: (context) => const BxSplashWidgetTablet(),
              ),
            ),
      ),
    );
  }
}
