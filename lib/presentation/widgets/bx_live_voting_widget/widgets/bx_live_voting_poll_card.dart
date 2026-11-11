// File: lib/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_poll_card.dart
// Architecture: Presentation Layer - Live Voting Widgets
// Purpose: The current poll card (badge + subtitle + question + total + options)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_poll_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingPollCard extends StatelessWidget {
  const BxLiveVotingPollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxLiveVotingControllerBloc, BxLiveVotingControllerState>(
      // Rebuild on poll change, options change, or status change.
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.activePollIndex != curr.activePollIndex ||
          prev.polls != curr.polls,
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxLiveVotingStatus.initial ||
            state.status == BxLiveVotingStatus.loading) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 60.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: BxAppColors.primary),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxLiveVotingStatus.error) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: BxAppColors.error,
                  size: 40.sp,
                ),
                SizedBox(height: 12.h),
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: BxAppColors.error, fontSize: 12.sp),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => context
                      .read<BxLiveVotingControllerBloc>()
                      .add(BxLiveVotingLoadRequested()),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: BxAppColors.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // --- Success ---
        final poll = state.activePoll;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge + subtitle
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4A017),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          poll.badge,
                          style: TextStyle(
                            color: const Color(0xFFD4A017),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    poll.subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Question
              Text(
                poll.question,
                style: TextStyle(
                  color: BxAppColors.onSurface,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 8.h),

              // Total votes
              Text(
                poll.totalVotes,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),

              // Options
              ...poll.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < poll.options.length - 1 ? 12.h : 0,
                  ),
                  child: BxLiveVotingPollOption(
                    option: option,
                    onTap: () => context.read<BxLiveVotingControllerBloc>().add(
                      BxLiveVotingOptionSelected(index),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
