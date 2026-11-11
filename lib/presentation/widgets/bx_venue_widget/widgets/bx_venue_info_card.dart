// File: lib/presentation/widgets/bx_venue_widget/widgets/bx_venue_info_card.dart
// Architecture: Presentation Layer - Venue Widgets
// Purpose: Dark blue card showing the venue name + date

// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxVenueInfoCard extends StatelessWidget {
  final String venueName;
  final String venueDate;

  const BxVenueInfoCard({
    super.key,
    required this.venueName,
    required this.venueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF152B5D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            venueName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.lightBlueAccent,
                size: 14.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                venueDate,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
