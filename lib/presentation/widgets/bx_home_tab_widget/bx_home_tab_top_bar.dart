// File: lib/presentation/widgets/bx_home_tab_widget/widgets/bx_home_tab_top_bar.dart
// Architecture: Presentation Layer - Bx Home Tab Widgets
// Purpose: "NESTLÉ MEDICAL CONGRESS" label + notification bell icon

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabTopBar extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const BxHomeTabTopBar({super.key, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'NESTLÉ MEDICAL CONGRESS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 22.sp,
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 7.w,
                  height: 7.w,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
