// File: lib/presentation/widgets/bx_home_widget/widgets/bx_profile_avatar.dart
// Architecture: Presentation Layer - Bx Profile Widgets
// Purpose: Circular avatar with a thin mixed-colour gradient border + edit badge

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileAvatar extends StatelessWidget {
  final String initials;
  final double? size;

  const BxProfileAvatar({super.key, required this.initials, this.size});

  @override
  Widget build(BuildContext context) {
    final s = size ?? 85.w;
    // Thin border thickness — same visual weight as the original 3px border.
    final borderWidth = 3.w;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // --- Avatar with mixed-colour gradient border ---
        Container(
          width: s,
          height: s,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                Color(0xFF00B4D8), // Light blue
                Color(0xFFFFD54F), // Gold
                Color(0xFF00B4D8), // Light blue
              ],
              stops: [0.0, 0.5, 1.0],
              startAngle: 0.0,
              endAngle: 3.14159 * 2,
            ),
          ),
          child: Padding(
            // Thin ring (border width)
            padding: EdgeInsets.all(borderWidth),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: const Color(0xFF0B1B40),
                    fontSize: s * 0.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        // --- Edit badge (unchanged) ---
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD54F),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF0B1B40), width: 2),
          ),
          child: Icon(
            Icons.edit,
            color: const Color(0xFF0B1B40),
            size: s * 0.14,
          ),
        ),
      ],
    );
  }
}
