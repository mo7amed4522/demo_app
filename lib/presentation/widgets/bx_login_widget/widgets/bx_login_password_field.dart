// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_password_field.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Password field with visibility toggle (isolated rebuilds)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const BxLoginPasswordField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        obscureText: context.select(
          (BxLoginScreenControllerBloc bloc) => !bloc.state.isPasswordVisible,
        ),
        onChanged: onChanged,
        style: TextStyle(fontSize: 13.sp, color: BxAppColors.onSurface),
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: TextStyle(fontSize: 13.sp),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: BxAppColors.primary,
            size: 20.sp,
          ),
          // ONLY the eye icon rebuilds on state change
          suffixIcon:
              BlocBuilder<
                BxLoginScreenControllerBloc,
                BxLoginScreenControllerState
              >(
                buildWhen: (previous, current) =>
                    previous.isPasswordVisible != current.isPasswordVisible,
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<BxLoginScreenControllerBloc>().add(
                        BxTogglePasswordVisibility(),
                      );
                    },
                  );
                },
              ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}
