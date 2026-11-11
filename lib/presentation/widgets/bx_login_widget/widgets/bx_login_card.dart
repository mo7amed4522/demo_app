// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_card.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Main login card containing all form elements

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_divider.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_forgot_password.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_password_field.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_social_buttons.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_submit_button.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final double? titleFontSize;
  final double? subtitleFontSize;
  final double? padding;
  final double? fieldSpacing;
  final double? buttonHeight;
  final double? shieldIconSize;

  const BxLoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.titleFontSize,
    this.subtitleFontSize,
    this.padding,
    this.fieldSpacing,
    this.buttonHeight,
    this.shieldIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding ?? 20.w),
      decoration: BoxDecoration(
        color: BxAppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: titleFontSize ?? 20.sp,
                        fontWeight: FontWeight.bold,
                        color: BxAppColors.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Sign in to continue your congress experience',
                      style: TextStyle(
                        fontSize: subtitleFontSize ?? 11.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                BxAppConstant.shieldIcon,
                width: shieldIconSize ?? 30.sp,
                height: shieldIconSize ?? 30.sp,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          BxLoginTextField(
            controller: emailController,
            hint: 'Enter your email',
            icon: Icons.person_outline,
            onChanged: (value) => context
                .read<BxLoginScreenControllerBloc>()
                .add(BxEmailChanged(value)),
          ),
          SizedBox(height: fieldSpacing ?? 12.h),
          BxLoginPasswordField(
            controller: passwordController,
            onChanged: (value) => context
                .read<BxLoginScreenControllerBloc>()
                .add(BxPasswordChanged(value)),
          ),
          SizedBox(height: 20.h),
          BxLoginSubmitButton(height: buttonHeight),
          SizedBox(height: 20.h),
          const BxLoginDivider(),
          SizedBox(height: 16.h),
          const BxLoginSocialButtons(),
          SizedBox(height: 16.h),
          const BxLoginForgotPassword(),
        ],
      ),
    );
  }
}
