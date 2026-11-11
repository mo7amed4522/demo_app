// File: lib/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_grid_item.dart
// Architecture: Presentation Layer - Quick Access Widgets
// Purpose: A single tappable card inside the grid

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessGridItem extends StatelessWidget {
  final BxQuickAccessItem item;
  final VoidCallback? onTap;

  const BxQuickAccessGridItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon tile
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    BxAppColors.primary,
                    BxAppColors.primary.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: BxAppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(item.icon, color: Colors.white, size: 24.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              item.title,
              style: TextStyle(
                color: BxAppColors.onSurface,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 10.sp,
                height: 1.3,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: BxAppColors.accentGold.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    item.tag,
                    style: TextStyle(
                      color: BxAppColors.onSurface,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: BxAppColors.primary,
                  size: 16.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
