// File: lib/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_info_row.dart
// Architecture: Presentation Layer - Name Tag Widgets
// Purpose: Single info row (icon + title + value)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const BxNameTagInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(icon, color: BxAppColors.primary, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 9.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  value,
                  style: TextStyle(
                    color: BxAppColors.onSurface,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
