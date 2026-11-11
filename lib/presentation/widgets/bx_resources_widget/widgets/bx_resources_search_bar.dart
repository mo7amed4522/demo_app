// File: lib/presentation/widgets/bx_resources_widget/widgets/bx_resources_search_bar.dart
// Architecture: Presentation Layer - Resources Widgets
// Purpose: Bordered search field wired to the BLoC

import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const BxResourcesSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (val) => context.read<BxResourcesControllerBloc>().add(
        BxResourcesSearchChanged(val),
      ),
      decoration: InputDecoration(
        hintText: 'Search resources',
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
