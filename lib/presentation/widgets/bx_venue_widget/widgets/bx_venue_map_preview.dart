// File: lib/presentation/widgets/bx_venue_widget/widgets/bx_venue_map_preview.dart
// Architecture: Presentation Layer - Venue Widgets
// Purpose: Map preview tile with custom painted lines + gold center pin

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/widgets/bx_venue_widget/widgets/bx_venue_map_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxVenueMapPreview extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double? height;

  const BxVenueMapPreview({
    super.key,
    required this.label,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height ?? 160.h,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F4FD),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            // Map lines background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CustomPaint(painter: const BxVenueMapPainter()),
              ),
            ),

            // "Map Preview" chip
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: BxAppColors.onSurface,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Gold center pin
            Center(
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: BxAppColors.accentGold,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: BxAppColors.accentGold.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.location_on,
                  color: BxAppColors.darkBackground,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
