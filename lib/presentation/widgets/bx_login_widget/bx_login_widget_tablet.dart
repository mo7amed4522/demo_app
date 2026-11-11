// File: lib/presentation/widget/bx_login_widget/bx_login_widget_tablet.dart
// Architecture: Presentation Layer - Bx Login Screen
// Purpose: Tablet-specific login screen layout with wider spacing

import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_badge.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_bottom_bar.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_card.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_create_account.dart';
import 'package:demo_app/presentation/widgets/bx_login_widget/widgets/bx_login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginWidgetTablet extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const BxLoginWidgetTablet({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                const BxLoginBadge(
                  fontSize: 12,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                SizedBox(height: 24.h),
                const BxLoginHeader(
                  titleFontSize: 38,
                  subtitleFontSize: 18,
                  dividerWidth: 100,
                  dividerHeight: 3,
                ),
                SizedBox(height: 36.h),
                BxLoginCard(
                  emailController: emailController,
                  passwordController: passwordController,
                  titleFontSize: 26,
                  subtitleFontSize: 14,
                  padding: 32,
                  fieldSpacing: 16,
                  buttonHeight: 56,
                  shieldIconSize: 38,
                ),
                SizedBox(height: 32.h),
                BxLoginCreateAccount(
                  fontSize: 15,
                  onTap: () =>
                      BxAppRouter.push(context, BxRouteNames.bxRegisterScreen),
                ),
                SizedBox(height: 32.h),
                const BxLoginBottomBar(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
