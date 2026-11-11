// File: lib/presentation/views/bx_home_screen/bx_home_screen.dart
// Architecture: Presentation Layer - Bx Home Screen
// Purpose: Router wrapper + BLoC providers + responsive shell delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:demo_app/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_bloc.dart';
import 'package:demo_app/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/bx_home_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/bx_home_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxHomeScreen extends StatelessWidget {
  const BxHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BxHomeScreenControllerBloc()),
        BlocProvider(
          create: (_) =>
              BxHomeTabControllerBloc()..add(BxHomeTabLoadRequested()),
        ),
        BlocProvider(
          create: (_) =>
              BxProfileTabControllerBloc()..add(BxProfileTabLoadRequested()),
        ),
      ],
      child: const BxResponsiveBuilder(
        mobileBuilder: _mobileShell,
        tabletBuilder: _tabletShell,
        desktopBuilder: _tabletShell,
      ),
    );
  }

  static Widget _mobileShell(BuildContext context) =>
      const BxHomeWidgetMobile();

  static Widget _tabletShell(BuildContext context) =>
      const BxHomeWidgetTablet();
}
