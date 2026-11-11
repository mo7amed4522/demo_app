// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_social_buttons.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Google and Apple social login buttons

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginSocialButtons extends StatelessWidget {
  const BxLoginSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSocialButton(iconData: BxAppConstant.googleIcon)),
        SizedBox(width: 12.w),
        Expanded(child: _buildSocialButton(iconData: BxAppConstant.appleIcon)),
      ],
    );
  }

  Widget _buildSocialButton({required String iconData}) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Image.asset(iconData, width: 22.sp, height: 22.sp),
      ),
    );
  }
}
