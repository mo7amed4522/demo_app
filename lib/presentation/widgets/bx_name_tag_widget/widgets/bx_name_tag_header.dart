// File: lib/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_header.dart
// Architecture: Presentation Layer - Name Tag Widgets
// Purpose: Top header (back button + title + print icon)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onPrint;

  const BxNameTagHeader({super.key, required this.onBack, this.onPrint});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.all(8.w),
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
          'My Name Tag',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onPrint,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.print,
              color: BxAppColors.accentGold,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
