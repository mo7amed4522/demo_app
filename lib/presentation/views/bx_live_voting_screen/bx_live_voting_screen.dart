// File: lib/presentation/views/bx_live_voting_screen/bx_live_voting_screen.dart
// Architecture: Presentation Layer - Live Voting Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/bx_live_voting_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/bx_live_voting_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxLiveVotingScreen extends StatelessWidget {
  const BxLiveVotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxLiveVotingControllerBloc()..add(BxLiveVotingLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxLiveVotingWidgetMobile(),
          tabletBuilder: (context) => const BxLiveVotingWidgetTablet(),
          desktopBuilder: (context) => const BxLiveVotingWidgetTablet(),
        ),
      ),
    );
  }
}
