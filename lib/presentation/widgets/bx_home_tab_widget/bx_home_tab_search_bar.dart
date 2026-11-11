// File: lib/presentation/widgets/bx_home_tab_widget/widgets/bx_home_tab_search_bar.dart
// Architecture: Presentation Layer - Bx Home Tab Widgets
// Purpose: Dark blue search bar with search + filter icons

import 'package:demo_app/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabSearchBar extends StatelessWidget {
  final double? height;

  const BxHomeTabSearchBar({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFF122B5D),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(Icons.search, color: Colors.white70, size: 22.sp),
          ),
          Expanded(
            child: TextField(
              onChanged: (val) => context.read<BxHomeTabControllerBloc>().add(
                BxHomeTabSearchChanged(val),
              ),
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
              cursorColor: const Color(0xFF00C6FF),
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: 'Search sessions, speakers, topics...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                color: Color(0xFF00C6FF),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.tune, color: Colors.white, size: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
