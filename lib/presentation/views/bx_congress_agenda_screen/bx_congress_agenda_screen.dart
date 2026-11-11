// File: lib/presentation/views/bx_congress_agenda_screen/bx_congress_agenda_screen.dart
// Architecture: Presentation Layer - Congress Agenda Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/bx_congress_agenda_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/bx_congress_agenda_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxCongressAgendaScreen extends StatelessWidget {
  const BxCongressAgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxCongressAgendaControllerBloc()
            ..add(BxCongressAgendaLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxCongressAgendaWidgetMobile(),
          tabletBuilder: (context) => const BxCongressAgendaWidgetTablet(),
          desktopBuilder: (context) => const BxCongressAgendaWidgetTablet(),
        ),
      ),
    );
  }
}
