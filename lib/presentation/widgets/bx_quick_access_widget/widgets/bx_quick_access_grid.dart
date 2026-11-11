// File: lib/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_grid.dart
// Architecture: Presentation Layer - Quick Access Widgets
// Purpose: Responsive grid of quick access cards — rebuilds on filter/search/status

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_quick_access_widget/widgets/bx_quick_access_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxQuickAccessGrid extends StatelessWidget {
  final int? crossAxisCount;
  final double? childAspectRatio;

  const BxQuickAccessGrid({
    super.key,
    this.crossAxisCount,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxQuickAccessControllerBloc,
      BxQuickAccessControllerState
    >(
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.selectedFilterIndex != curr.selectedFilterIndex ||
          prev.searchQuery != curr.searchQuery ||
          prev.allItems != curr.allItems,
      builder: (context, state) {
        if (state.status == BxQuickAccessStatus.error) {
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
                      .read<BxQuickAccessControllerBloc>()
                      .add(BxQuickAccessLoadRequested()),
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

        final items = state.visibleItems;

        if (items.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No items match your search',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
              ),
            ),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount ?? 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: childAspectRatio ?? 0.85,
          ),
          itemBuilder: (context, index) => BxQuickAccessGridItem(
            item: items[index],
            onTap: () => _navigateToItem(context, items[index]),
          ),
        );
      },
    );
  }

  void _navigateToItem(BuildContext context, BxQuickAccessItem item) {
    final routeName = switch (item.title) {
      'Agenda' => BxRouteNames.bxCongressAgendaScreen,
      'Speakers' => BxRouteNames.bxSpeakersScreen,
      'Name Tag' => BxRouteNames.bxNameTagScreen,
      'Venue' => BxRouteNames.bxVenueScreen,
      'Voting' => BxRouteNames.bxLiveVotingScreen,
      'Ask Q&A' => BxRouteNames.bxAskQaScreen,
      'Resources' => BxRouteNames.bxResourcesScreen,
      _ => null,
    };

    if (routeName != null) {
      BxAppRouter.push(context, routeName);
    }
  }
}
