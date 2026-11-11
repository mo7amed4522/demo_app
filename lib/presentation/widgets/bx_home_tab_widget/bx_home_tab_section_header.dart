// File: lib/presentation/widgets/bx_home_tab_widget/widgets/bx_home_tab_section_header.dart
// Architecture: Presentation Layer - Bx Home Tab Widgets
// Purpose: "Section Title ... View All ›" header

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final double? fontSize;

  const BxHomeTabSectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize ?? 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                'View All ',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 11.sp,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.lightBlueAccent,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
