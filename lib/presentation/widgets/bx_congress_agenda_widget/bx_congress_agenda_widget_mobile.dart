// File: lib/presentation/widgets/bx_congress_agenda_widget/bx_congress_agenda_widget_mobile.dart
// Architecture: Presentation Layer - Congress Agenda Shell
// Purpose: Mobile shell — header + banner + day toggle + white sheet with chips + list

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_day_banner.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_day_toggle.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_header.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_session_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaWidgetMobile extends StatelessWidget {
  const BxCongressAgendaWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // --- Header ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxCongressAgendaHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 16.h),

          // --- Day schedule banner (reads selected day from state) ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                BlocBuilder<
                  BxCongressAgendaControllerBloc,
                  BxCongressAgendaControllerState
                >(
                  buildWhen: (prev, curr) =>
                      prev.selectedDayIndex != curr.selectedDayIndex,
                  builder: (context, state) {
                    return BxCongressAgendaDayBanner(
                      title:
                          '${BxCongressAgendaControllerState.dayTitles[state.selectedDayIndex]} Schedule',
                      fullDate: BxCongressAgendaControllerState
                          .dayFullDates[state.selectedDayIndex],
                    );
                  },
                ),
          ),
          SizedBox(height: 16.h),

          // --- Day toggles ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const BxCongressAgendaDayToggle(),
          ),
          SizedBox(height: 24.h),

          // --- White sheet ---
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
                  // "Today's Sessions" + Reset
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 24.h,
                      bottom: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Sessions",
                          style: TextStyle(
                            color: BxAppColors.onSurface,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => context
                              .read<BxCongressAgendaControllerBloc>()
                              .add(BxCongressAgendaResetRequested()),
                          icon: Icon(
                            Icons.refresh,
                            color: BxAppColors.primary,
                            size: 16.sp,
                          ),
                          label: Text(
                            'Reset',
                            style: TextStyle(
                              color: BxAppColors.primary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Filter chips
                  const BxCongressAgendaFilterChips(),
                  SizedBox(height: 16.h),

                  // Sessions list
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 4.h,
                      ),
                      child: const BxCongressAgendaSessionList(),
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
