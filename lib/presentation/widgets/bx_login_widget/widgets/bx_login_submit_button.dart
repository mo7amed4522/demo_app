// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_submit_button.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: Gradient sign-in button with loading state

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/widgets/bx_loading_app.dart';
import 'package:demo_app/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginSubmitButton extends StatelessWidget {
  final double? height;

  const BxLoginSubmitButton({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxLoginScreenControllerBloc,
      BxLoginScreenControllerState
    >(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: height ?? 48.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [BxAppColors.primary, BxAppColors.secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: ElevatedButton(
            onPressed: state.status == BxLoginStatus.loading
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    context.read<BxLoginScreenControllerBloc>().add(
                      BxLoginSubmitted(),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: state.status == BxLoginStatus.loading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: BxLoadingApp.lottieWidget(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In  ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
