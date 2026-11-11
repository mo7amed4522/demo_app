// File: lib/presentation/views/bx_resources_screen/bx_resources_screen.dart
// Architecture: Presentation Layer - Resources Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/bx_resources_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/bx_resources_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxResourcesScreen extends StatelessWidget {
  const BxResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxResourcesControllerBloc()..add(BxResourcesLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxResourcesWidgetMobile(),
          tabletBuilder: (context) => const BxResourcesWidgetTablet(),
          desktopBuilder: (context) => const BxResourcesWidgetTablet(),
        ),
      ),
    );
  }
}
