// File: lib/presentation/widgets/bx_home_widget/bx_home_widget_tablet.dart
// Architecture: Presentation Layer - Bx Home Shell
// Purpose: Tablet shell — PageView (Home + Profile tabs) + wider bottom nav bar

import 'package:demo_app/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:demo_app/presentation/views/bx_home_screen/tablet/bx_home_tab_view_tablet.dart';
import 'package:demo_app/presentation/views/bx_home_screen/tablet/bx_profile_tab_view_tablet.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BxHomeWidgetTablet extends StatelessWidget {
  const BxHomeWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxHomeScreenControllerBloc>();

    return BlocListener<
      BxHomeScreenControllerBloc,
      BxHomeScreenControllerState
    >(
      listenWhen: (prev, curr) => prev.activeTabIndex != curr.activeTabIndex,
      listener: (context, state) {
        if (bloc.pageController.hasClients &&
            bloc.pageController.page?.round() != state.activeTabIndex) {
          bloc.pageController.animateToPage(
            state.activeTabIndex,
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOutCubic,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1B40),
        body: Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                bottom: false,
                child: PageView(
                  controller: bloc.pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    final current = context
                        .read<BxHomeScreenControllerBloc>()
                        .state
                        .activeTabIndex;
                    if (current != index) {
                      context.read<BxHomeScreenControllerBloc>().add(
                        BxHomeScreenControllerTabChanged(index),
                      );
                    }
                  },
                  children: const [
                    BxHomeTabViewTablet(),
                    BxProfileTabViewTablet(),
                  ],
                ),
              ),
            ),
            // Bottom nav bar (tablet sizing — taller, wider, bigger icons)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child:
                  BlocBuilder<
                    BxHomeScreenControllerBloc,
                    BxHomeScreenControllerState
                  >(
                    buildWhen: (p, c) => p.activeTabIndex != c.activeTabIndex,
                    builder: (context, state) {
                      return BxHomeBottomNavBar(
                        activeIndex: state.activeTabIndex,
                        height: 64,
                        itemWidthFactor: 0.28,
                        iconSize: 26,
                        labelFontSize: 15,
                        borderRadius: 24,
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
