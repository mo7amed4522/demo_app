// File: lib/presentation/widgets/bx_resources_widget/bx_resources_widget_mobile.dart
// Architecture: Presentation Layer - Resources Shell
// Purpose: Mobile shell — header + banner + white sheet with search + chips + list

import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_banner.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_header.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_list.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesWidgetMobile extends StatelessWidget {
  const BxResourcesWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxResourcesControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxResourcesHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 12.h),

          // Banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const BxResourcesBanner(),
          ),
          SizedBox(height: 24.h),

          // White sheet
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
              child: Column(
                children: [
                  // Search bar
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 24.h,
                    ),
                    child: BxResourcesSearchBar(
                      controller: bloc.searchController,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Filter chips
                  const BxResourcesFilterChips(),
                  SizedBox(height: 20.h),

                  // List
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 4.h,
                      ),
                      child: const BxResourcesList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
