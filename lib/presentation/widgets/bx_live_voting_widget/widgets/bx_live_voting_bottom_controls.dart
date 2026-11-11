// File: lib/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_bottom_controls.dart
// Architecture: Presentation Layer - Live Voting Widgets
// Purpose: Floating bottom row (left arrow + "Next Poll" + right arrow)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingBottomControls extends StatelessWidget {
  const BxLiveVotingBottomControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxLiveVotingControllerBloc, BxLiveVotingControllerState>(
      // Only rebuild when the enabled/disabled state of arrows can change.
      buildWhen: (prev, curr) =>
          prev.activePollIndex != curr.activePollIndex ||
          prev.polls.length != curr.polls.length,
      builder: (context, state) {
        return Row(
          children: [
            // Previous
            _arrowButton(
              icon: Icons.arrow_back,
              enabled: state.canGoPrevious,
              onTap: () => context.read<BxLiveVotingControllerBloc>().add(
                BxLiveVotingPreviousPoll(),
              ),
            ),
            SizedBox(width: 12.w),

            // Next Poll (primary gradient)
            Expanded(
              child: GestureDetector(
                onTap: () => context.read<BxLiveVotingControllerBloc>().add(
                  BxLiveVotingNextPollButtonTapped(),
                ),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0056D2), Color(0xFF00C6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0056D2).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Next Poll',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Next
            _arrowButton(
              icon: Icons.arrow_forward,
              enabled: state.canGoNext,
              onTap: () => context.read<BxLiveVotingControllerBloc>().add(
                BxLiveVotingNextPoll(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _arrowButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: BxAppColors.primary, size: 20.sp),
        ),
      ),
    );
  }
}
