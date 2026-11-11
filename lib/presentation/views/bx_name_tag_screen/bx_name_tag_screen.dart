// File: lib/presentation/views/bx_name_tag_screen/bx_name_tag_screen.dart
// Architecture: Presentation Layer - Name Tag Screen
// Purpose: Router wrapper + BLoC provider (triggers load) + responsive delegation

import 'package:demo_app/core/responsive/bx_responsive_builder.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/bx_name_tag_widget_mobile.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/bx_name_tag_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxNameTagScreen extends StatelessWidget {
  const BxNameTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxNameTagControllerBloc()..add(BxNameTagLoadRequested()),
      child: Scaffold(
        backgroundColor: BxAppColors.background,
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxNameTagWidgetMobile(),
          tabletBuilder: (context) => const BxNameTagWidgetTablet(),
          desktopBuilder: (context) => const BxNameTagWidgetTablet(),
        ),
      ),
    );
  }
}
