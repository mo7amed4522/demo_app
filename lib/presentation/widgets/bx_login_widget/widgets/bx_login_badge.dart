// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_badge.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Top badge showing "NESTLÉ MEDICAL CONGRESS"

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginBadge extends StatelessWidget {
  final double? fontSize;
  final EdgeInsets? padding;

  const BxLoginBadge({super.key, this.fontSize, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: BxAppColors.accentGold, width: 1.2),
      ),
      child: Text(
        'NESTLÉ MEDICAL CONGRESS',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? 10.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
