// File: lib/presentation/widget/bx_splash_widget/bx_splash_widget_mobile.dart
// Architecture: Presentation Layer - Bx Splash Screen
// Purpose: Mobile-specific splash screen layout

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/widgets/bx_loading_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSplashWidgetMobile extends StatelessWidget {
  const BxSplashWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NESTLÉ',
              style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              'CONGRESS',
              style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.w900,
                color: BxAppColors.accentGold,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 12.h),
            Container(height: 3.h, width: 60.w, color: BxAppColors.accentGold),
            SizedBox(height: 16.h),
            Text(
              'The Next Era of\nNutrition & Health',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: 120.w,
              height: 70.w,
              child: BxLoadingApp.lottieWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
