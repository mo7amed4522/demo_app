// File: lib/presentation/widgets/bx_register_widget/widgets/bx_register_terms_checkbox.dart
// Architecture: Presentation Layer - Bx Register Widgets
// Purpose: Terms & conditions checkbox row

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxRegisterTermsCheckbox extends StatelessWidget {
  final bool isAccepted;
  final VoidCallback onToggle;
  final double? textFontSize;

  const BxRegisterTermsCheckbox({
    super.key,
    required this.isAccepted,
    required this.onToggle,
    this.textFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              color: isAccepted ? BxAppColors.primary : Colors.transparent,
              border: Border.all(
                color: isAccepted ? BxAppColors.primary : Colors.grey.shade400,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: isAccepted
                ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                : null,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'I agree to the congress terms, privacy policy and attendee '
              'guidelines.',
              style: TextStyle(
                fontSize: textFontSize ?? 10.sp,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
