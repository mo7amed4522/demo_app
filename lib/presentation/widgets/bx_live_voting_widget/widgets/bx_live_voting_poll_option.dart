// File: lib/presentation/widgets/bx_live_voting_widget/widgets/bx_live_voting_poll_option.dart
// Architecture: Presentation Layer - Live Voting Widgets
// Purpose: A single tappable poll option row (radio + title + % + progress bar)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLiveVotingPollOption extends StatelessWidget {
  final BxPollOption option;
  final VoidCallback? onTap;

  const BxLiveVotingPollOption({super.key, required this.option, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: option.isSelected ? const Color(0xFFE3F2FD) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: option.isSelected
                ? BxAppColors.primary
                : Colors.grey.shade200,
            width: option.isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            // Top row: radio + title + percentage
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: option.isSelected
                        ? BxAppColors.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: option.isSelected
                          ? BxAppColors.primary
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: option.isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 12.sp)
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    option.title,
                    style: TextStyle(
                      color: BxAppColors.onSurface,
                      fontSize: 13.sp,
                      fontWeight: option.isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  option.percentage,
                  style: TextStyle(
                    color: option.isSelected
                        ? BxAppColors.primary
                        : Colors.grey.shade700,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Bottom row: progress bar + votes
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: (option.progressValue * 100).toInt().clamp(
                            0,
                            100,
                          ),
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: option.progressColor,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:
                              100 -
                              (option.progressValue * 100).toInt().clamp(
                                0,
                                100,
                              ),
                          child: const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  option.votes,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
