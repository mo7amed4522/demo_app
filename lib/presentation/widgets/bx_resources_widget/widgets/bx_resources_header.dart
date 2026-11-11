// File: lib/presentation/widgets/bx_resources_widget/widgets/bx_resources_header.dart
// Architecture: Presentation Layer - Resources Widgets
// Purpose: Top header (back + title + folder icon)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesHeader extends StatelessWidget {
  final VoidCallback onBack;

  const BxResourcesHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
        Text(
          'Resources',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Icon(
            Icons.folder_open_outlined,
            color: BxAppColors.accentGold,
            size: 20,
          ),
        ),
      ],
    );
  }
}
