// File: lib/presentation/widgets/bx_register_widget/bx_register_widget_mobile.dart
// Architecture: Presentation Layer - Bx Register Screen
// Purpose: Mobile-specific register screen layout

import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_card.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_header.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_sign_in_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterWidgetMobile extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController hospitalController;
  final TextEditingController passwordController;
  final VoidCallback onSignInTap;

  const BxRegisterWidgetMobile({
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            const BxRegisterHeader(),
            SizedBox(height: 20.h),
            BxRegisterCard(
              nameController: nameController,
              emailController: emailController,
              hospitalController: hospitalController,
              passwordController: passwordController,
            ),
            SizedBox(height: 20.h),
            BxRegisterSignInLink(onTap: onSignInTap),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
