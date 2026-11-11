// File: lib/presentation/widgets/bx_resources_widget/widgets/bx_resources_list.dart
// Architecture: Presentation Layer - Resources Widgets
// Purpose: State-aware list (loading / error / empty / success)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_resources_widget/widgets/bx_resources_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxResourcesList extends StatelessWidget {
  const BxResourcesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxResourcesControllerBloc, BxResourcesControllerState>(
      // Rebuild when status, filter, search, or resources list changes.
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.selectedFilterIndex != curr.selectedFilterIndex ||
          prev.searchQuery != curr.searchQuery ||
          prev.allResources != curr.allResources,
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxResourcesStatus.initial ||
            state.status == BxResourcesStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Center(
              child: CircularProgressIndicator(color: BxAppColors.primary),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxResourcesStatus.error) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: BxAppColors.error,
                  size: 40.sp,
                ),
                SizedBox(height: 12.h),
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: BxAppColors.error, fontSize: 12.sp),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => context
                      .read<BxResourcesControllerBloc>()
                      .add(BxResourcesLoadRequested()),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: BxAppColors.primary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // --- Success ---
        final resources = state.visibleResources;

        if (resources.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No resources match your search',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resources.length,
          itemBuilder: (context, index) =>
              BxResourcesCard(item: resources[index]),
        );
      },
    );
  }
}
