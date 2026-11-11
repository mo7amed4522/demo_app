// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_filter_chips.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: Horizontal filter chips — isolated BlocBuilder for selected filter only

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaFilterChips extends StatelessWidget {
  const BxCongressAgendaFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxCongressAgendaControllerBloc,
      BxCongressAgendaControllerState
    >(
      buildWhen: (prev, curr) =>
          prev.selectedFilterIndex != curr.selectedFilterIndex,
      builder: (context, state) {
        return SizedBox(
          height: 36.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: BxCongressAgendaControllerState.filters.length,
            itemBuilder: (context, index) {
              final isSelected = state.selectedFilterIndex == index;
              return GestureDetector(
                onTap: () => context.read<BxCongressAgendaControllerBloc>().add(
                  BxCongressAgendaFilterChanged(index),
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? BxAppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? BxAppColors.primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    BxCongressAgendaControllerState.filters[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
