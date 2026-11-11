// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_header.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Register screen title header ("Join the NESTLÉ CONGRESS")

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterHeader extends StatelessWidget {
  final double joinFontSize;
  final double brandFontSize;
  final double subtitleFontSize;

  const BxRegisterHeader({
    super.key,
    this.joinFontSize = 26,
    this.brandFontSize = 32,
    this.subtitleFontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Join the',
          style: TextStyle(
            fontSize: joinFontSize.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        Text(
          'NESTLÉ',
          style: TextStyle(
            fontSize: brandFontSize.sp,
            fontWeight: FontWeight.w900,
            color: BxAppColors.accentGold,
            letterSpacing: 1.0,
            height: 1.1,
          ),
        ),
        Text(
          'CONGRESS',
          style: TextStyle(
            fontSize: brandFontSize.sp,
            fontWeight: FontWeight.w900,
            color: BxAppColors.accentGold,
            letterSpacing: 1.0,
            height: 1.1,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Create your attendee profile and access sessions, resources, '
            'voting and Q&A.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleFontSize.sp,
              color: Colors.white70,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
