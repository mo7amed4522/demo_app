// File: lib/presentation/widgets/bx_congress_agenda_widget/bx_congress_agenda_widget_tablet.dart
// Architecture: Presentation Layer - Congress Agenda Shell
// Purpose: Tablet shell — wider paddings, capped content width

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

class BxCongressAgendaWidgetTablet extends StatelessWidget {
  const BxCongressAgendaWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxCongressAgendaHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
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
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: const BxCongressAgendaDayToggle(),
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
                      bottom: 16.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Sessions",
                          style: TextStyle(
                            color: BxAppColors.onSurface,
                            fontSize: 20.sp,
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
                            size: 18.sp,
                          ),
                          label: Text(
                            'Reset',
                            style: TextStyle(
                              color: BxAppColors.primary,
                              fontSize: 14.sp,
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
                  const BxCongressAgendaFilterChips(),
                  SizedBox(height: 20.h),
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
                          child: const BxCongressAgendaSessionList(),
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
