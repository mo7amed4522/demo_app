// File: lib/presentation/views/bx_quick_access_screen/bx_quick_access_screen.dart
// Architecture: Presentation Layer - Quick Access Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/bx_quick_access_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/bx_quick_access_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxQuickAccessScreen extends StatelessWidget {
  const BxQuickAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxQuickAccessControllerBloc()..add(BxQuickAccessLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxQuickAccessWidgetMobile(),
          tabletBuilder: (context) => const BxQuickAccessWidgetTablet(),
          desktopBuilder: (context) => const BxQuickAccessWidgetTablet(),
        ),
      ),
    );
  }
}
