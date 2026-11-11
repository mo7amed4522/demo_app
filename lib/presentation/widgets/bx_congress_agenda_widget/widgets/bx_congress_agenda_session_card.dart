// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_session_card.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: A single session card (time / icon / tag / title / bookmark / location)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaSessionCard extends StatelessWidget {
  final BxAgendaSession session;

  const BxCongressAgendaSessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFDE8C4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Time ---
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                session.time,
                style: TextStyle(
                  color: BxAppColors.primary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                session.period,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Container(width: 1, height: 50.h, color: Colors.grey.shade200),
          SizedBox(width: 5.w),

          // --- Icon ---
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: session.iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(session.icon, color: session.iconColor, size: 18.sp),
          ),
          SizedBox(width: 10.w),

          // --- Content ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Text(
                  session.tag,
                  style: TextStyle(
                    color: const Color(0xFFE6A81D),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),

                // Title + bookmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        session.title,
                        style: TextStyle(
                          color: const Color(0xFF1C1E24),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => context
                          .read<BxCongressAgendaControllerBloc>()
                          .add(BxCongressAgendaBookmarkToggled(session.title)),
                      child: Icon(
                        session.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: session.isBookmarked
                            ? BxAppColors.primary
                            : Colors.grey.shade400,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Speaker / location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey.shade400,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        session.speaker,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
