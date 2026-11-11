// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_forgot_password.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Forgot password text button

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginForgotPassword extends StatelessWidget {
  final VoidCallback? onPressed;

  const BxLoginForgotPassword({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(Icons.lock_outline, size: 14.sp, color: BxAppColors.primary),
        label: Text(
          'Forgot password?',
          style: TextStyle(
            color: BxAppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
