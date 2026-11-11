// File: lib/presentation/widgets/bx_home_tab_widget/widgets/bx_home_tab_featured_card.dart
// Architecture: Presentation Layer - Bx Home Tab Widgets
// Purpose: Featured event card with gradient, badge, glowing plant icon

// ignore_for_file: deprecated_member_use

import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_home_plant_icon_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabFeaturedCard extends StatelessWidget {
  final String title;
  final String dateLocation;
  final double? footprintWidth;
  final double? visualSize;

  const BxHomeTabFeaturedCard({
    super.key,
    this.title = 'The Next Era of\nNutrition & Health',
    this.dateLocation = 'May 22 - 23, 2026  •  Dubai, UAE',
    this.footprintWidth,
    this.visualSize,
  });

  @override
  Widget build(BuildContext context) {
    final footprint = footprintWidth ?? 80.w;
    final visual = visualSize ?? 120.w;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1D376C), Color(0xFF0D1D40)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFFFD54F), width: 1),
            ),
            child: Text(
              'FEATURED EVENT',
              style: TextStyle(
                color: const Color(0xFFFFD54F),
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(
                width: footprint,
                height: 45.h,
                child: OverflowBox(
                  maxWidth: visual * 0.85,
                  maxHeight: visual * 0.85,
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: visual,
                    height: visual,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.lightBlueAccent.withOpacity(0.35),
                          Colors.transparent,
                        ],
                        stops: const [0.1, 1.0],
                      ),
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: Size(50.w, 50.w),
                        painter: const BxHomePlantIconPainter(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            dateLocation,
            style: TextStyle(color: Colors.white60, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}
