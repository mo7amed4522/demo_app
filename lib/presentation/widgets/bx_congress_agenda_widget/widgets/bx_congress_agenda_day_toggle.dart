// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_day_toggle.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: Day 1 / Day 2 toggle row — isolated BlocBuilder for selected day only

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaDayToggle extends StatelessWidget {
  const BxCongressAgendaDayToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxCongressAgendaControllerBloc,
      BxCongressAgendaControllerState
    >(
      buildWhen: (prev, curr) => prev.selectedDayIndex != curr.selectedDayIndex,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _toggle(
                context,
                index: 0,
                title: BxCongressAgendaControllerState.dayTitles[0],
                date: BxCongressAgendaControllerState.dayDates[0],
                isSelected: state.selectedDayIndex == 0,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _toggle(
                context,
                index: 1,
                title: BxCongressAgendaControllerState.dayTitles[1],
                date: BxCongressAgendaControllerState.dayDates[1],
                isSelected: state.selectedDayIndex == 1,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _toggle(
    BuildContext context, {
    required int index,
    required String title,
    required String date,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<BxCongressAgendaControllerBloc>().add(
        BxCongressAgendaDayChanged(index),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? BxAppColors.accentGold
              : const Color(0xFF1E3A8A).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? BxAppColors.background : Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              date,
              style: TextStyle(
                color: isSelected
                    ? BxAppColors.background.withOpacity(0.7)
                    : Colors.white70,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
