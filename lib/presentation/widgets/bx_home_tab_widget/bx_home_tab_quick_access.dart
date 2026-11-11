// File: lib/presentation/widgets/bx_home_tab_widget/widgets/bx_home_tab_quick_access.dart
// Architecture: Presentation Layer - Bx Home Tab Widgets
// Purpose: Quick Access 2x4 grid with routing

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/routes/bx_app_routes.dart';
import 'package:demo_app/core/routes/bx_route_names.dart';
import 'package:demo_app/presentation/widgets/bx_home_tab_widget/bx_home_tab_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxHomeTabQuickAccess extends StatelessWidget {
  final double? iconSize;
  final double? labelFontSize;
  final double? verticalPadding;
  final double? gap;

  const BxHomeTabQuickAccess({
    super.key,
    this.iconSize,
    this.labelFontSize,
    this.verticalPadding,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final h = gap ?? 8.w;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BxHomeTabSectionHeader(
          title: 'Quick Access',
          onViewAll: () =>
              BxAppRouter.push(context, BxRouteNames.bxQuickAccessScreen),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _item(context, Icons.calendar_today_outlined, 'Agenda', () {
              BxAppRouter.push(context, BxRouteNames.bxCongressAgendaScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.people_outline, 'Speakers', () {
              BxAppRouter.push(context, BxRouteNames.bxSpeakersScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.badge_outlined, 'Name Tag', () {
              BxAppRouter.push(context, BxRouteNames.bxNameTagScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.location_on_outlined, 'Venue', () {
              BxAppRouter.push(context, BxRouteNames.bxVenueScreen);
            }),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            _item(context, Icons.poll_outlined, 'Voting', () {
              BxAppRouter.push(context, BxRouteNames.bxLiveVotingScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.help_outline, 'Ask Q&A', () {
              BxAppRouter.push(context, BxRouteNames.bxAskQaScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.folder_outlined, 'Resources', () {
              BxAppRouter.push(context, BxRouteNames.bxResourcesScreen);
            }),
            SizedBox(width: h),
            _item(context, Icons.storefront_outlined, 'Exhibitors', null),
          ],
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF132750),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.lightBlueAccent,
                size: iconSize ?? 20.sp,
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: labelFontSize ?? 8.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
