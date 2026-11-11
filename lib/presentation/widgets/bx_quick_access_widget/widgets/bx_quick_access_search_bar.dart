// File: lib/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_search_bar.dart
// Architecture: Presentation Layer - Quick Access Widgets
// Purpose: Inline search field wired to the BLoC

import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const BxQuickAccessSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (val) => context.read<BxQuickAccessControllerBloc>().add(
        BxQuickAccessSearchChanged(val),
      ),
      decoration: InputDecoration(
        hintText: 'Search quick access',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade400,
          size: 20.sp,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
      ),
    );
  }
}
