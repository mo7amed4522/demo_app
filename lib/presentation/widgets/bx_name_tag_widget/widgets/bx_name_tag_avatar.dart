// File: lib/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_avatar.dart
// Architecture: Presentation Layer - Name Tag Widgets
// Purpose: Split-colour ring avatar with initials

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagAvatar extends StatelessWidget {
  final String initials;
  final double? size;

  const BxNameTagAvatar({super.key, required this.initials, this.size});

  @override
  Widget build(BuildContext context) {
    final s = size ?? 75.w;
    return Container(
      width: s,
      height: s,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [Color(0xFF00B4D8), Color(0xFFFFD54F), Color(0xFF00B4D8)],
          stops: [0.0, 0.5, 1.0],
          startAngle: 0.0,
          endAngle: 3.14159 * 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(s * 0.033),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                color: const Color(0xFF0056D2),
                fontSize: s * 0.29,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
