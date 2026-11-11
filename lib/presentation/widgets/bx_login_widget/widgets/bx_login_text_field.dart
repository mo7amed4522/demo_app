// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_text_field.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Reusable styled text field for the login form

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const BxLoginTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(fontSize: 13.sp, color: BxAppColors.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13.sp),
          prefixIcon: Icon(icon, color: BxAppColors.primary, size: 20.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}
