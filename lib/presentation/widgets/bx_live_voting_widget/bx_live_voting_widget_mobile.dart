// File: lib/presentation/widgets/bx_live_voting_widget/bx_live_voting_widget_mobile.dart
// Architecture: Presentation Layer - Live Voting Shell
// Purpose: Mobile shell — header + banner + white sheet (dots + poll) + floating controls

import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_banner.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_bottom_controls.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_header.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_pagination_dots.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_poll_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingWidgetMobile extends StatelessWidget {
  const BxLiveVotingWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // --- Main content ---
          Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: BxLiveVotingHeader(onBack: () => Navigator.pop(context)),
              ),
              SizedBox(height: 12.h),

              // Banner
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const BxLiveVotingBanner(),
              ),
              SizedBox(height: 24.h),

              // White sheet
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        const BxLiveVotingPaginationDots(),
                        SizedBox(height: 20.h),
                        const BxLiveVotingPollCard(),
                        SizedBox(height: 80.h), // space for floating controls
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- Floating bottom controls ---
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 24.h,
            child: const BxLiveVotingBottomControls(),
          ),
        ],
      ),
    );
  }
}
