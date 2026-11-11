// File: lib/presentation/views/bx_speakers_screen/bx_speakers_screen.dart
// Architecture: Presentation Layer - Speakers Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation
//          (stateless — controllers live in BLoC)

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/bx_speakers_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/bx_speakers_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxSpeakersScreen extends StatelessWidget {
  const BxSpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxSpeakersControllerBloc()..add(BxSpeakersLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxSpeakersWidgetMobile(),
          tabletBuilder: (context) => const BxSpeakersWidgetTablet(),
          desktopBuilder: (context) => const BxSpeakersWidgetTablet(),
        ),
      ),
    );
  }
}
