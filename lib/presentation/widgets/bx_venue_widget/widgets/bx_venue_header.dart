// File: lib/presentation/widgets/bx_venue_widget/widgets/bx_venue_header.dart
// Architecture: Presentation Layer - Venue Widgets
// Purpose: Top header (back button + title + navigation icon)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxVenueHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onNavigate;

  const BxVenueHeader({super.key, required this.onBack, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
        Text(
          'Venue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onNavigate,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.navigation,
              color: BxAppColors.accentGold,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
