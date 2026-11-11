// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_day_banner.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: "Day X Schedule" banner

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaDayBanner extends StatelessWidget {
  final String title;
  final String fullDate;

  const BxCongressAgendaDayBanner({
    super.key,
    required this.title,
    required this.fullDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.calendar_month, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                fullDate,
                style: TextStyle(color: Colors.white70, fontSize: 11.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
