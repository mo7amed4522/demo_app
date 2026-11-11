// File: lib/presentation/widgets/bx_resources_widget/widgets/bx_resources_card.dart
// Architecture: Presentation Layer - Resources Widgets
// Purpose: A single resource card (icon + tag/title/subtitle/size + bookmark/download)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesCard extends StatelessWidget {
  final BxResourceItem item;

  const BxResourcesCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Icon tile ---
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 24.sp),
          ),
          SizedBox(width: 16.w),

          // --- Content ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Text(
                  item.tag,
                  style: TextStyle(
                    color: item.tagColor,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),

                // Title
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BxAppColors.onSurface,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),

                // Subtitle
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 8.h),

                // File size
                Row(
                  children: [
                    Icon(
                      Icons.dns_outlined,
                      color: Colors.grey.shade400,
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item.size,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // --- Bookmark + Download ---
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.read<BxResourcesControllerBloc>().add(
                  BxResourcesBookmarkToggled(item.title),
                ),
                child: Icon(
                  item.isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: item.isSaved
                      ? BxAppColors.accentGold
                      : Colors.grey.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => context.read<BxResourcesControllerBloc>().add(
                  BxResourcesDownloadToggled(item.title),
                ),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: BxAppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    item.isDownloaded
                        ? Icons.check_circle_outline_rounded
                        : Icons.file_download_outlined,
                    color: BxAppColors.primary,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
