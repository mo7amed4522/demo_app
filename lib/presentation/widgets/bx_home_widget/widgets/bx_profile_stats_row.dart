// File: lib/presentation/widgets/bx_home_widget/widgets/bx_profile_stats_row.dart
// Architecture: Presentation Layer - Bx Profile Widgets
// Purpose: Three stat cards (Sessions / Saved / Certificates)

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileStatsRow extends StatelessWidget {
  final int sessions;
  final int saved;
  final int certificates;

  const BxProfileStatsRow({
    super.key,
    required this.sessions,
    required this.saved,
    required this.certificates,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _card('$sessions', 'Sessions', Icons.calendar_today_outlined),
        SizedBox(width: 12.w),
        _card(saved.toString().padLeft(2, '0'), 'Saved', Icons.bookmark_border),
        SizedBox(width: 12.w),
        _card(
          certificates.toString().padLeft(2, '0'),
          'Certificates',
          Icons.workspace_premium_outlined,
        ),
      ],
    );
  }

  Widget _card(String count, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade100, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 20.sp),
            SizedBox(height: 8.h),
            Text(
              count,
              style: TextStyle(
                color: const Color(0xFF1C1E24),
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 9.sp),
            ),
          ],
        ),
      ),
    );
  }
}
