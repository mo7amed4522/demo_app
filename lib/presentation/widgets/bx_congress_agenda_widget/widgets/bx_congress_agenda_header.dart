// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_header.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: Top header (back button + title + search button)

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onSearch;

  const BxCongressAgendaHeader({
    super.key,
    required this.onBack,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
        Text(
          'Congress Agenda',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onSearch,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.search, color: Colors.white, size: 18.sp),
          ),
        ),
      ],
    );
  }
}
