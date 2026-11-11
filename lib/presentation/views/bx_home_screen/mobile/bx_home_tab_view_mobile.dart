// File: lib/presentation/views/bx_home_screen/mobile/bx_home_tab_view_mobile.dart
// Architecture: Presentation Layer - Bx Home Screen (Mobile)
// Purpose: Home tab content for mobile devices

import 'package:demo_app/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_featured_card.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_quick_access.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_search_bar.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_section_header.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabViewMobile extends StatelessWidget {
  const BxHomeTabViewMobile({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BxHomeTabTopBar(),
              SizedBox(height: 16.h),
              Text(
                'Welcome Back,\nDr. Testing 👋',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16.h),
              const BxHomeTabSearchBar(),
              SizedBox(height: 20.h),
              const BxHomeTabFeaturedCard(),
              SizedBox(height: 20.h),
              const BxHomeTabQuickAccess(),
              SizedBox(height: 20.h),
              BxHomeTabSectionHeader(
                title: 'Upcoming Sessions',
                onViewAll: () {},
              ),
              SizedBox(height: 80.h),
            ],
          ),
        );
      },
    );
  }
}
