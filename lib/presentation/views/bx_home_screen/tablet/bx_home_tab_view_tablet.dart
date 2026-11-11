// File: lib/presentation/views/bx_home_screen/tablet/bx_home_tab_view_tablet.dart
// Architecture: Presentation Layer - Bx Home Screen (Tablet)
// Purpose: Home tab content for tablet devices — larger sizing, wider padding

import 'package:demo_app/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_featured_card.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_quick_access.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_search_bar.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_section_header.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabViewTablet extends StatelessWidget {
  const BxHomeTabViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxHomeTabControllerBloc, BxHomeTabControllerState>(
      builder: (context, state) {
        if (state.status == BxHomeTabStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.h),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 900.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BxHomeTabTopBar(),
                  SizedBox(height: 24.h),
                  Text(
                    'Welcome Back,\nDr. Testing 👋',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BxHomeTabSearchBar(height: 64.h),
                  SizedBox(height: 32.h),
                  BxHomeTabFeaturedCard(
                    footprintWidth: 140.w,
                    visualSize: 200.w,
                  ),
                  SizedBox(height: 32.h),
                  BxHomeTabQuickAccess(
                    iconSize: 28.sp,
                    labelFontSize: 11.sp,
                    verticalPadding: 18.h,
                    gap: 14.w,
                  ),
                  SizedBox(height: 32.h),
                  BxHomeTabSectionHeader(
                    title: 'Upcoming Sessions',
                    onViewAll: () {},
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
