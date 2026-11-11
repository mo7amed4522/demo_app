// File: lib/presentation/views/bx_ask_qa_screen/bx_ask_qa_screen.dart
// Architecture: Presentation Layer - Ask Q&A Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/bx_ask_qa_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/bx_ask_qa_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxAskQaScreen extends StatelessWidget {
  const BxAskQaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxAskQaControllerBloc()..add(BxAskQaLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxAskQaWidgetMobile(),
          tabletBuilder: (context) => const BxAskQaWidgetTablet(),
          desktopBuilder: (context) => const BxAskQaWidgetTablet(),
        ),
      ),
    );
  }
}
