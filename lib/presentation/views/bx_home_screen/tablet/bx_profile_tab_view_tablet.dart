// File: lib/presentation/views/bx_home_screen/tablet/bx_profile_tab_view_tablet.dart
// Architecture: Presentation Layer - Bx Profile Screen (Tablet)
// Purpose: Profile tab content for tablet devices — bigger avatar, wider layout

import 'package:demo_app/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_info_card.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_stats_row.dart';
import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileTabViewTablet extends StatelessWidget {
  const BxProfileTabViewTablet({super.key});

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
              titleFontSize: 26.sp,
              avatarSize: 130.w,
              nameFontSize: 30.sp,
              roleFontSize: 16.sp,
              idFontSize: 14.sp,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 64.w,
                    vertical: 32.h,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800.w),
                      child: Column(
                        children: [
                          BxProfileInfoCard(
                            email: state.email,
                            phone: state.phone,
                            location: state.location,
                          ),
                          SizedBox(height: 32.h),
                          BxProfileStatsRow(
                            sessions: state.sessionsCount,
                            saved: state.savedCount,
                            certificates: state.certificatesCount,
                          ),
                          SizedBox(height: 100.h), // bottom nav spacing
                        ],
                      ),
                    ),
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
