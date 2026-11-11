// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_bottom_bar.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Glassmorphism bottom bar with feature highlights

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginBottomBar extends StatelessWidget {
  const BxLoginBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(
            Icons.people_outline,
            'Global\nExperts',
            color: Colors.lightBlueAccent,
          ),
          Container(height: 35.h, width: 1, color: Colors.white24),
          _buildBottomNavItem(
            Icons.calendar_today_outlined,
            'Knowledge\nSessions',
            color: Colors.lightBlueAccent,
          ),
          Container(height: 35.h, width: 1, color: Colors.white24),
          _buildBottomNavItem(
            Icons.star_border,
            'Networking\nOpportunities',
            color: BxAppColors.accentGold,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String text, {
    required Color color,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: color.withOpacity(0.5), width: 1),
              ),
              child: Icon(icon, color: color, size: 16.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
