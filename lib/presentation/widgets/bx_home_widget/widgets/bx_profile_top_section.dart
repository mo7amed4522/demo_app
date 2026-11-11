// File: lib/presentation/widgets/bx_home_widget/widgets/bx_profile_top_section.dart
// Architecture: Presentation Layer - Bx Profile Widgets
// Purpose: Profile header with back button, settings, avatar, name, role, ID

// ignore_for_file: deprecated_member_use

import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileTopSection extends StatelessWidget {
  final String name;
  final String role;
  final String id;
  final String initials;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  /// Optional tablet sizing overrides
  final double? titleFontSize;
  final double? avatarSize;
  final double? nameFontSize;
  final double? roleFontSize;
  final double? idFontSize;

  const BxProfileTopSection({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.initials,
    this.onBack,
    this.onSettings,
    this.titleFontSize,
    this.avatarSize,
    this.nameFontSize,
    this.roleFontSize,
    this.idFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize ?? 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onSettings,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          BxProfileAvatar(initials: initials, size: avatarSize),
          SizedBox(height: 16.h),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: nameFontSize ?? 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            role,
            style: TextStyle(
              color: Colors.white70,
              fontSize: roleFontSize ?? 12.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFFFD54F), width: 1),
            ),
            child: Text(
              'ID: $id',
              style: TextStyle(
                color: const Color(0xFFFFD54F),
                fontSize: idFontSize ?? 10.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
