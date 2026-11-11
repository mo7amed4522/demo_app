// File: lib/presentation/widgets/bx_resources_widget/bx_resources_widget_tablet.dart
// Architecture: Presentation Layer - Resources Shell
// Purpose: Tablet shell — wider padding, capped content width

import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_banner.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_header.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_list.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesWidgetTablet extends StatelessWidget {
  const BxResourcesWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxResourcesControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxResourcesHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: const BxResourcesBanner(),
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 64.w,
                      right: 64.w,
                      top: 32.h,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 900.w),
                        child: BxResourcesSearchBar(
                          controller: bloc.searchController,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const BxResourcesFilterChips(),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 64.w,
                        vertical: 4.h,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 900.w),
                          child: const BxResourcesList(),
                        ),
                      ),
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
