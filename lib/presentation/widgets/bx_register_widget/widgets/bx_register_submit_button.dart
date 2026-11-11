// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_submit_button.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Gradient "Create Account" button with loading state

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterSubmitButton extends StatelessWidget {
  final double? height;

  const BxRegisterSubmitButton({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxRegisterScreenControllerBloc,
      BxRegisterScreenControllerState
    >(
      // Only rebuilds when the loading status flips.
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
            onPressed: state.status == BxRegisterStatus.loading
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    context.read<BxRegisterScreenControllerBloc>().add(
                      BxRegisterSubmitted(),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: state.status == BxRegisterStatus.loading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
