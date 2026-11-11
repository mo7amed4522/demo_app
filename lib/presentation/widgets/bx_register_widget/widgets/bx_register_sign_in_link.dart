// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_sign_in_link.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: "Already have an account? Sign In" bottom link

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterSignInLink extends StatelessWidget {
  final VoidCallback onTap;
  final double? fontSize;

  const BxRegisterSignInLink({super.key, required this.onTap, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final size = fontSize ?? 12.sp;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white70, fontSize: size),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Sign In",
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
