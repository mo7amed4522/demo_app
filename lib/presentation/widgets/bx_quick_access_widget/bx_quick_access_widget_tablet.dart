// File: lib/presentation/widgets/bx_quick_access_widget/bx_quick_access_widget_tablet.dart
// Architecture: Presentation Layer - Quick Access Shell
// Purpose: Tablet shell — same structure, wider padding, 3-column grid

import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_banner.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_grid.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_header.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessWidgetTablet extends StatelessWidget {
  const BxQuickAccessWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxQuickAccessControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxQuickAccessHeader(
              onBack: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: const BxQuickAccessBanner(),
          ),
          SizedBox(height: 32.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 32.h),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 900.w),
                    child: Column(
                      children: [
                        BxQuickAccessSearchBar(
                          controller: bloc.searchController,
                        ),
                        SizedBox(height: 24.h),
                        const BxQuickAccessFilterChips(),
                        SizedBox(height: 32.h),
                        const BxQuickAccessGrid(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
