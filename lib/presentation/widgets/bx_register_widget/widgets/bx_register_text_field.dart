// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_text_field.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Reusable styled text field for the register form
//          (optionally supports password mode with visibility toggle)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onToggleVisibility;

  const BxRegisterTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.onChanged,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
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
        obscureText: isPassword ? !isPasswordVisible : false,
        onChanged: onChanged,
        style: TextStyle(fontSize: 13.sp, color: BxAppColors.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
          prefixIcon: Icon(icon, color: BxAppColors.primary, size: 18.sp),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}
