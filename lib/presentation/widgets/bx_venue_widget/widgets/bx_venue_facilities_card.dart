// File: lib/presentation/widgets/bx_venue_widget/widgets/bx_venue_facilities_card.dart
// Architecture: Presentation Layer - Venue Widgets
// Purpose: White card with a 2-column facility grid

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_venue_controller/bx_venue_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxVenueFacilitiesCard extends StatelessWidget {
  final List<BxVenueFacility> facilities;

  const BxVenueFacilitiesCard({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    // Render facilities in rows of 2 (preserves the original layout).
    final rows = <Widget>[];
    for (var i = 0; i < facilities.length; i += 2) {
      final left = facilities[i];
      final right = (i + 1 < facilities.length) ? facilities[i + 1] : null;

      rows.add(
        Row(
          children: [
            _buildFacilityItem(left),
            SizedBox(width: 12.w),
            if (right != null) _buildFacilityItem(right) else const Spacer(),
          ],
        ),
      );

      if (i + 2 < facilities.length) SizedBox(height: 12.h);
      if (i + 2 < facilities.length) rows.add(SizedBox(height: 12.h));
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Venue Facilities',
            style: TextStyle(
              color: BxAppColors.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildFacilityItem(BxVenueFacility facility) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8FF),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(facility.icon, color: BxAppColors.primary, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              facility.label,
              style: TextStyle(
                color: BxAppColors.onSurface,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
