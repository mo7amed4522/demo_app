// File: lib/presentation/widgets/bx_live_voting_widget/bx_live_voting_widget_tablet.dart
// Architecture: Presentation Layer - Live Voting Shell
// Purpose: Tablet shell — wider padding, capped content width, taller sheet padding

import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_banner.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_bottom_controls.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_header.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_pagination_dots.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_poll_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingWidgetTablet extends StatelessWidget {
  const BxLiveVotingWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
                child: BxLiveVotingHeader(onBack: () => Navigator.pop(context)),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: const BxLiveVotingBanner(),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
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
                            const BxLiveVotingPaginationDots(),
                            SizedBox(height: 24.h),
                            const BxLiveVotingPollCard(),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 64.w,
            right: 64.w,
            bottom: 32.h,
            child: const BxLiveVotingBottomControls(),
          ),
        ],
      ),
    );
  }
}
