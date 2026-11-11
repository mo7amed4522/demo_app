// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_header.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Branding header with NESTLÉ CONGRESS title and subtitle

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginHeader extends StatelessWidget {
  final double titleFontSize;
  final double subtitleFontSize;
  final double dividerWidth;
  final double dividerHeight;

  const BxLoginHeader({
    super.key,
    this.titleFontSize = 28,
    this.subtitleFontSize = 14,
    this.dividerWidth = 60,
    this.dividerHeight = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'NESTLÉ',
          style: TextStyle(
            fontSize: titleFontSize.sp,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          'CONGRESS',
          style: TextStyle(
            fontSize: titleFontSize.sp,
            fontWeight: FontWeight.w900,
            color: BxAppColors.accentGold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: dividerHeight.h,
          width: dividerWidth.w,
          color: BxAppColors.accentGold,
        ),
        SizedBox(height: 12.h),
        Text(
          'The Next Era of\nNutrition & Health',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: subtitleFontSize.sp,
            color: Colors.white70,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
