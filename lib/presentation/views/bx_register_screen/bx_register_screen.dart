// File: lib/presentation/views/bx_register_screen/bx_register_screen.dart
// Architecture: Presentation Layer - Bx Register Screen
// Purpose: Register screen layout (stateless — controllers live in the BLoC)

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/widgets/bx_custom_snack_bar.dart';
import 'package:demo_app/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/bx_register_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/bx_register_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxRegisterPage extends StatelessWidget {
  const BxRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BxRegisterScreenControllerBloc(),
      child: const BxRegisterScreen(),
    );
  }
}

class BxRegisterScreen extends StatelessWidget {
  const BxRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxRegisterScreenControllerBloc>();

    return Scaffold(
      backgroundColor: BxAppColors.background,
      body:
          BlocListener<
            BxRegisterScreenControllerBloc,
            BxRegisterScreenControllerState
          >(
            listener: (context, state) {
              if (state.status == BxRegisterStatus.failure &&
                  state.errorMessage != null) {
                BxCustomSnackBar.error(
                  context: context,
                  message: state.errorMessage ?? 'An error occurred',
                );
              }
              if (state.status == BxRegisterStatus.success) {
                BxCustomSnackBar.success(
                  context: context,
                  message: 'Account created successfully!',
                );
                Navigator.pop(context);
              }
            },
            // --- Responsive delegation ---
            child: BxResponsiveBuilder(
              mobileBuilder: (context) => BxRegisterWidgetMobile(
                nameController: bloc.nameController,
                emailController: bloc.emailController,
                hospitalController: bloc.hospitalController,
                passwordController: bloc.passwordController,
                onSignInTap: () => Navigator.pop(context),
              ),
              tabletBuilder: (context) => BxRegisterWidgetTablet(
                nameController: bloc.nameController,
                emailController: bloc.emailController,
                hospitalController: bloc.hospitalController,
                passwordController: bloc.passwordController,
                onSignInTap: () => Navigator.pop(context),
              ),
              desktopBuilder: (context) => BxRegisterWidgetTablet(
                nameController: bloc.nameController,
                emailController: bloc.emailController,
                hospitalController: bloc.hospitalController,
                passwordController: bloc.passwordController,
                onSignInTap: () => Navigator.pop(context),
              ),
            ),
          ),
    );
  }
}
