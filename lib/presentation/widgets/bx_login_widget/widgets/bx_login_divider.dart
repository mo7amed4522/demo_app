// File: lib/presentation/widget/bx_login_widget/widgets/bx_login_divider.dart
// Architecture: Presentation Layer - Bx Login Widgets
// Purpose: "OR CONTINUE WITH" divider

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxLoginDivider extends StatelessWidget {
  const BxLoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 9.sp,
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
