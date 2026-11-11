// File: lib/presentation/widgets/bx_register_widget/bx_register_widget_tablet.dart
// Architecture: Presentation Layer - Bx Register Screen
// Purpose: Tablet-specific register screen layout with larger sizing

import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_card.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_header.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_sign_in_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterWidgetTablet extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController hospitalController;
  final TextEditingController passwordController;
  final VoidCallback onSignInTap;

  const BxRegisterWidgetTablet({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.hospitalController,
    required this.passwordController,
    required this.onSignInTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 620.w),
            child: Column(
              children: [
                const BxRegisterHeader(
                  joinFontSize: 34,
                  brandFontSize: 42,
                  subtitleFontSize: 15,
                ),
                SizedBox(height: 32.h),
                BxRegisterCard(
                  nameController: nameController,
                  emailController: emailController,
                  hospitalController: hospitalController,
                  passwordController: passwordController,
                  padding: 32,
                  fieldSpacing: 16,
                  buttonHeight: 56,
                  termsFontSize: 12,
                ),
                SizedBox(height: 32.h),
                BxRegisterSignInLink(onTap: onSignInTap, fontSize: 14),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
