// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_divider.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: "OR SIGN UP WITH" divider

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterDivider extends StatelessWidget {
  const BxRegisterDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'OR SIGN UP WITH',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
