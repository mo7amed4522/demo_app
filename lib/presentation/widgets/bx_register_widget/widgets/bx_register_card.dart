// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_card.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Main register card containing all form fields, terms, submit button
//          and social options. Sizing can be tuned per device via constructor.

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_divider.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_social_buttons.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_submit_button.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_terms_checkbox.dart';
import 'package:demo_app/presentation/widgets/bx_register_widget/widgets/bx_register_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController hospitalController;
  final TextEditingController passwordController;

  final double? padding;
  final double? fieldSpacing;
  final double? buttonHeight;
  final double? termsFontSize;

  const BxRegisterCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.hospitalController,
    required this.passwordController,
    this.padding,
    this.fieldSpacing,
    this.buttonHeight,
    this.termsFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding != null
          ? EdgeInsets.all(padding!)
          : EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: BxAppColors.surface,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child:
          BlocBuilder<
            BxRegisterScreenControllerBloc,
            BxRegisterScreenControllerState
          >(
            buildWhen: (previous, current) {
              return previous.isPasswordVisible != current.isPasswordVisible ||
                  previous.isTermsAccepted != current.isTermsAccepted ||
                  previous.status != current.status;
            },
            builder: (context, state) {
              return Column(
                children: [
                  BxRegisterTextField(
                    controller: nameController,
                    hint: 'Full name',
                    icon: Icons.person_outline,
                    onChanged: (val) => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterNameChanged(val)),
                  ),
                  SizedBox(height: fieldSpacing ?? 10.h),
                  BxRegisterTextField(
                    controller: emailController,
                    hint: 'Email address',
                    icon: Icons.email_outlined,
                    onChanged: (val) => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterEmailChanged(val)),
                  ),
                  SizedBox(height: fieldSpacing ?? 10.h),
                  BxRegisterTextField(
                    controller: hospitalController,
                    hint: 'Hospital / Organization',
                    icon: Icons.local_hospital_outlined,
                    onChanged: (val) => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterHospitalChanged(val)),
                  ),
                  SizedBox(height: fieldSpacing ?? 10.h),
                  BxRegisterTextField(
                    controller: passwordController,
                    hint: 'Create password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isPasswordVisible: state.isPasswordVisible,
                    onToggleVisibility: () => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterTogglePasswordVisibility()),
                    onChanged: (val) => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterPasswordChanged(val)),
                  ),
                  SizedBox(height: 14.h),
                  BxRegisterTermsCheckbox(
                    isAccepted: state.isTermsAccepted,
                    textFontSize: termsFontSize,
                    onToggle: () => context
                        .read<BxRegisterScreenControllerBloc>()
                        .add(BxRegisterToggleTerms()),
                  ),
                  SizedBox(height: 20.h),
                  BxRegisterSubmitButton(height: buttonHeight),
                  SizedBox(height: 16.h),
                  const BxRegisterDivider(),
                  SizedBox(height: 14.h),
                  const BxRegisterSocialButtons(),
                ],
              );
            },
          ),
    );
  }
}
