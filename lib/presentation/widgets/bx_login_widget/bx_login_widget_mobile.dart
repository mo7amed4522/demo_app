// File: lib/presentation/widget/bx_login_widget/bx_login_widget_mobile.dart
// Architecture: Presentation Layer - Bx Login Screen
// Purpose: Mobile-specific login screen layout

import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_badge.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_bottom_bar.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_card.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_create_account.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginWidgetMobile extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const BxLoginWidgetMobile({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const BxLoginBadge(),
            SizedBox(height: 16.h),
            const BxLoginHeader(),
            SizedBox(height: 24.h),
            BxLoginCard(
              emailController: emailController,
              passwordController: passwordController,
            ),
            SizedBox(height: 24.h),
            BxLoginCreateAccount(
              onTap: () =>
                  BxAppRouter.push(context, BxRouteNames.bxRegisterScreen),
            ),
            SizedBox(height: 24.h),
            const BxLoginBottomBar(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
