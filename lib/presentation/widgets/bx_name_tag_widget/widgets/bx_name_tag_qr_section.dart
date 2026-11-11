// File: lib/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_qr_section.dart
// Architecture: Presentation Layer - Name Tag Widgets
// Purpose: QR code placeholder tile

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagQrSection extends StatelessWidget {
  final double? size;
  final double? iconSize;

  const BxNameTagQrSection({super.key, this.size, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final s = size ?? 120.w;
    return Center(
      child: Container(
        width: s,
        height: s,
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Icon(
            Icons.qr_code_2,
            color: BxAppColors.background.withOpacity(0.9),
            size: iconSize ?? 80.sp,
          ),
        ),
      ),
    );
  }
}
