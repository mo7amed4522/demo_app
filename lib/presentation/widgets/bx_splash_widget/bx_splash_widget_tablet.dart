// File: lib/presentation/widget/bx_splash_widget/bx_splash_widget_tablet.dart
// Architecture: Presentation Layer - Bx Splash Screen
// Purpose: Tablet-specific splash screen layout

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/widgets/bx_loading_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSplashWidgetTablet extends StatelessWidget {
  const BxSplashWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Logo / Branding ---
            Text(
              'NESTLÉ',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
            Text(
              'CONGRESS',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w900,
                color: BxAppColors.accentGold,
                letterSpacing: 3.0,
              ),
            ),
            SizedBox(height: 20.h),
            Container(height: 4.h, width: 120.w, color: BxAppColors.accentGold),
            SizedBox(height: 24.h),
            Text(
              'The Next Era of\nNutrition & Health',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white70,
                height: 1.5,
              ),
            ),

            SizedBox(height: 56.h),

            // --- Loading Indicator ---
            SizedBox(
              width: 180.w,
              height: 110.w,
              child: BxLoadingApp.lottieWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
