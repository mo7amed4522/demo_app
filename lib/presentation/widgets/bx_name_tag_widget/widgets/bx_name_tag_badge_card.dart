// File: lib/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_badge_card.dart
// Architecture: Presentation Layer - Name Tag Widgets
// Purpose: The full badge card (gradient header + avatar + name + info rows + QR)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_avatar.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_gradient_header.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_info_row.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_qr_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagBadgeCard extends StatelessWidget {
  /// Optional overrides used by the tablet layout.
  final double? padding;
  final double? nameFontSize;
  final double? avatarSize;
  final double? qrSize;
  final double? qrIconSize;

  const BxNameTagBadgeCard({
    super.key,
    this.padding,
    this.nameFontSize,
    this.avatarSize,
    this.qrSize,
    this.qrIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxNameTagControllerBloc, BxNameTagControllerState>(
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxNameTagStatus.initial ||
            state.status == BxNameTagStatus.loading) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding ?? 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(
                child: CircularProgressIndicator(color: BxAppColors.primary),
              ),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxNameTagStatus.error) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding ?? 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: BxAppColors.error,
                    size: 40.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    state.errorMessage ?? 'Something went wrong',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: BxAppColors.error, fontSize: 12.sp),
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => context
                        .read<BxNameTagControllerBloc>()
                        .add(BxNameTagLoadRequested()),
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        color: BxAppColors.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // --- Success ---
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding ?? 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Gradient header
              BxNameTagGradientHeader(
                title: state.congressTitle,
                subtitle: state.congressSubtitle,
              ),
              SizedBox(height: 16.h),

              // Avatar
              BxNameTagAvatar(initials: state.initials, size: avatarSize),
              SizedBox(height: 12.h),

              // Name
              Text(
                state.fullName,
                style: TextStyle(
                  color: BxAppColors.onSurface,
                  fontSize: nameFontSize ?? 18.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 2.h),

              // Role
              Text(
                state.role,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.h),

              // Divider with gold pin
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Icon(
                      Icons.workspace_premium,
                      color: BxAppColors.accentGold,
                      size: 20.sp,
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Info rows
              BxNameTagInfoRow(
                icon: Icons.badge_outlined,
                title: 'Badge ID',
                value: state.badgeId,
              ),
              SizedBox(height: 10.h),
              BxNameTagInfoRow(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: state.location,
              ),
              SizedBox(height: 10.h),
              BxNameTagInfoRow(
                icon: Icons.calendar_today_outlined,
                title: 'Congress Date',
                value: state.congressDate,
              ),
              SizedBox(height: 20.h),

              // QR placeholder
              BxNameTagQrSection(size: qrSize, iconSize: qrIconSize),
            ],
          ),
        );
      },
    );
  }
}
