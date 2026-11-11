// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_social_buttons.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Google and Apple sign-up buttons

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterSocialButtons extends StatelessWidget {
  const BxRegisterSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            iconData: Icons.g_mobiledata,
            iconColor: BxAppColors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSocialButton(
            iconData: Icons.apple,
            iconColor: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData iconData,
    required Color iconColor,
  }) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Icon(iconData, size: 24.sp, color: iconColor),
      ),
    );
  }
}
