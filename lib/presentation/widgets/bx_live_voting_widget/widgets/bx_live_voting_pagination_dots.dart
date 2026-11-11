// File: lib/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_pagination_dots.dart
// Architecture: Presentation Layer - Live Voting Widgets
// Purpose: Pagination dots row — isolated BlocBuilder for active poll index only

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingPaginationDots extends StatelessWidget {
  const BxLiveVotingPaginationDots({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxLiveVotingControllerBloc, BxLiveVotingControllerState>(
      buildWhen: (prev, curr) =>
          prev.activePollIndex != curr.activePollIndex ||
          prev.polls.length != curr.polls.length,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(state.polls.length, (index) {
            final isActive = state.activePollIndex == index;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: GestureDetector(
                onTap: () => context.read<BxLiveVotingControllerBloc>().add(
                  BxLiveVotingPollChanged(index),
                ),
                child: Container(
                  width: isActive ? 16.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: isActive
                        ? BxAppColors.primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
