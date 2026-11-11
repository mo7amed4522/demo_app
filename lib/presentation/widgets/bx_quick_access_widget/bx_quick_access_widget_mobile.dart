// File: lib/presentation/widgets/bx_quick_access_widget/bx_quick_access_widget_mobile.dart
// Architecture: Presentation Layer - Quick Access Shell
// Purpose: Mobile shell — header + banner + rounded white sheet with search/chips/grid

import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_banner.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_grid.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_header.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessWidgetMobile extends StatelessWidget {
  const BxQuickAccessWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxQuickAccessControllerBloc>();
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxQuickAccessHeader(
              onBack: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const BxQuickAccessBanner(),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    BxQuickAccessSearchBar(controller: bloc.searchController),
                    SizedBox(height: 20.h),
                    const BxQuickAccessFilterChips(),
                    SizedBox(height: 24.h),
                    const BxQuickAccessGrid(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
