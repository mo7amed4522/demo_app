// File: lib/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_header.dart
// Architecture: Presentation Layer - Quick Access Widgets
// Purpose: Top header (back button + title + grid icon)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessHeader extends StatelessWidget {
  final VoidCallback onBack;

  const BxQuickAccessHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
        Text(
          'Quick Access',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.grid_view_rounded,
            color: BxAppColors.accentGold,
            size: 16.sp,
          ),
        ),
      ],
    );
  }
}
