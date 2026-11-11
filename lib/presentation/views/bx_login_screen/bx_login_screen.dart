// File: lib/presentation/views/bx_login_screen/bx_login_screen.dart
// Architecture: Presentation Layer - Bx Login Screen
// Purpose: login screen layout

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/widgets/bx_custom_snack_bar.dart';
import 'package:demo_app/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/bx_login_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/bx_login_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxLoginPage extends StatelessWidget {
  const BxLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BxLoginScreenControllerBloc(),
      child: const BxLoginScreen(),
    );
  }
}

class BxLoginScreen extends StatelessWidget {
  const BxLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxLoginScreenControllerBloc>();

    return Scaffold(
      backgroundColor: BxAppColors.background,
      body:
          BlocListener<
            BxLoginScreenControllerBloc,
            BxLoginScreenControllerState
          >(
            listener: (context, state) {
              if (state.status == BxLoginStatus.failure &&
                  state.errorMessage != null) {
                BxCustomSnackBar.error(
                  context: context,
                  message: state.errorMessage ?? 'An error occurred',
                );
              }
              if (state.status == BxLoginStatus.success) {
                BxAppRouter.pushReplacement(context, BxRouteNames.bxHomeScreen);
              }
            },
            child: BxResponsiveBuilder(
              mobileBuilder: (context) => BxLoginWidgetMobile(
                emailController: bloc.emailController,
                passwordController: bloc.passwordController,
              ),
              tabletBuilder: (context) => BxLoginWidgetTablet(
                emailController: bloc.emailController,
                passwordController: bloc.passwordController,
              ),
              desktopBuilder: (context) => BxLoginWidgetTablet(
                emailController: bloc.emailController,
                passwordController: bloc.passwordController,
              ),
            ),
          ),
    );
  }
}
