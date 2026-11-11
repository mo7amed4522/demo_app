// File: lib/presentation/widgets/bx_home_widget/widgets/bx_profile_info_row.dart
// Architecture: Presentation Layer - Bx Profile Widgets
// Purpose: Single info row (icon + label + value)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const BxProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: const BoxDecoration(
            color: Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 18.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF1C1E24),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
