// File: lib/presentation/widgets/bx_home_widget/widgets/bx_profile_info_card.dart
// Architecture: Presentation Layer - Bx Profile Widgets
// Purpose: Contact info card (email / phone / location)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/presentation/widgets/bx_home_widget/widgets/bx_profile_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxProfileInfoCard extends StatelessWidget {
  final String email;
  final String phone;
  final String location;

  const BxProfileInfoCard({
    super.key,
    required this.email,
    required this.phone,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          BxProfileInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: email,
          ),
          Divider(color: Colors.grey.shade100, height: 24.h, thickness: 1),
          BxProfileInfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: phone,
          ),
          Divider(color: Colors.grey.shade100, height: 24.h, thickness: 1),
          BxProfileInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: location,
          ),
        ],
      ),
    );
  }
}
