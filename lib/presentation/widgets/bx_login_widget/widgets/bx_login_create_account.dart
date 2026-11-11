// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_create_account.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: "Don't have an account? Create Account" link

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginCreateAccount extends StatelessWidget {
  final VoidCallback? onTap;
  final double? fontSize;

  const BxLoginCreateAccount({super.key, this.onTap, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final size = fontSize ?? 12.sp;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70, fontSize: size),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Create Account →",
            style: TextStyle(
              color: BxAppColors.accentGold,
              fontWeight: FontWeight.bold,
              fontSize: size,
            ),
          ),
        ),
      ],
    );
  }
}
