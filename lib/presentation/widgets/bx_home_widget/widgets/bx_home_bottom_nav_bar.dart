// File: lib/presentation/widgets/bx_home_widget/widgets/bx_home_bottom_nav_bar.dart
// Architecture: Presentation Layer - Bx Home Widgets
// Purpose: Shared bottom navigation bar (sizes injected by mobile/tablet shells)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeBottomNavBar extends StatelessWidget {
  final int activeIndex;
  final double height;
  final double itemWidthFactor;
  final double iconSize;
  final double labelFontSize;
  final double borderRadius;

  const BxHomeBottomNavBar({
    super.key,
    required this.activeIndex,
    required this.height,
    required this.itemWidthFactor,
    required this.iconSize,
    required this.labelFontSize,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0A1636)),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(
                  context,
                  icon: Icons.home_filled,
                  label: 'Home',
                  isActive: activeIndex == 0,
                  index: 0,
                ),
                _navItem(
                  context,
                  icon: Icons.person_outline,
                  label: 'Profile',
                  isActive: activeIndex == 1,
                  index: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => context.read<BxHomeScreenControllerBloc>().add(
        BxHomeScreenControllerTabChanged(index),
      ),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width * itemWidthFactor,
        height: 50.h,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF15356E) : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: isActive
              ? Border.all(color: Colors.white.withOpacity(0.1), width: 1)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.lightBlueAccent : Colors.white54,
              size: iconSize.sp,
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white54,
                fontSize: labelFontSize.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
