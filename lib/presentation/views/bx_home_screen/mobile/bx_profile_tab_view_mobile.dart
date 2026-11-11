// File: lib/presentation/views/bx_home_screen/mobile/bx_profile_tab_view_mobile.dart
// Architecture: Presentation Layer - Bx Profile Screen (Mobile)
// Purpose: Profile tab content for mobile devices

import 'package:demo_app/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_info_card.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_stats_row.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileTabViewMobile extends StatelessWidget {
  const BxProfileTabViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxProfileTabControllerBloc, BxProfileTabControllerState>(
      builder: (context, state) {
        if (state.status == BxProfileTabStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return Column(
          children: [
            BxProfileTopSection(
              name: state.name,
              role: state.role,
              id: state.id,
              initials: 'HL',
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    children: [
                      BxProfileInfoCard(
                        email: state.email,
                        phone: state.phone,
                        location: state.location,
                      ),
                      SizedBox(height: 24.h),
                      BxProfileStatsRow(
                        sessions: state.sessionsCount,
                        saved: state.savedCount,
                        certificates: state.certificatesCount,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
