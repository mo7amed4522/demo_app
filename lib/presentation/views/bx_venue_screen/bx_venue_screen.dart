// File: lib/presentation/views/bx_venue_screen/bx_venue_screen.dart
// Architecture: Presentation Layer - Venue Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_venue_controller/bx_venue_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/bx_venue_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/bx_venue_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxVenueScreen extends StatelessWidget {
  const BxVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxVenueControllerBloc()..add(BxVenueLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxVenueWidgetMobile(),
          tabletBuilder: (context) => const BxVenueWidgetTablet(),
          desktopBuilder: (context) => const BxVenueWidgetTablet(),
        ),
      ),
    );
  }
}
