// File: lib/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_card.dart
// Architecture: Presentation Layer - Speakers Widgets
// Purpose: A single speaker card

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSpeakersCard extends StatelessWidget {
  final BxSpeaker speaker;

  const BxSpeakersCard({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: speaker.isFeatured
              ? const Color(0xFFFDE8C4)
              : Colors.grey.shade200,
          width: speaker.isFeatured ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF00B4D8),
                  Color(0xFFFFD54F),
                  Color(0xFF00B4D8),
                ],
                stops: [0.0, 0.5, 1.0],
                startAngle: 1.5708,
                endAngle: 9.8539,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    speaker.initials,
                    style: TextStyle(
                      color: const Color(0xFF0056D2),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Text(
                  speaker.tag,
                  style: TextStyle(
                    color: speaker.tagColor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        speaker.name,
                        style: TextStyle(
                          color: BxAppColors.onSurface,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.read<BxSpeakersControllerBloc>().add(
                        BxSpeakersStarToggled(speaker.name),
                      ),
                      child: Icon(
                        speaker.isStarred
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: speaker.isStarred
                            ? BxAppColors.accentGold
                            : Colors.grey.shade400,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  speaker.role,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey.shade400,
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      speaker.location,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        speaker.topic,
                        style: TextStyle(
                          color: BxAppColors.primary,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                      size: 18.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
