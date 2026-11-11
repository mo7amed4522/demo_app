// File: lib/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_session_list.dart
// Architecture: Presentation Layer - Congress Agenda Widgets
// Purpose: State-aware session list (loading / error / empty / success)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_congress_agenda_widget/widgets/bx_congress_agenda_session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxCongressAgendaSessionList extends StatelessWidget {
  const BxCongressAgendaSessionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxCongressAgendaControllerBloc,
      BxCongressAgendaControllerState
    >(
      // Rebuild when status, day, filter or sessions list changes.
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.selectedDayIndex != curr.selectedDayIndex ||
          prev.selectedFilterIndex != curr.selectedFilterIndex ||
          prev.allSessions != curr.allSessions,
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxCongressAgendaStatus.initial ||
            state.status == BxCongressAgendaStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Center(
              child: CircularProgressIndicator(color: BxAppColors.primary),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxCongressAgendaStatus.error) {
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
                      .read<BxCongressAgendaControllerBloc>()
                      .add(BxCongressAgendaLoadRequested()),
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

        // --- Success: show sessions or empty ---
        final sessions = state.visibleSessions;

        if (sessions.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No sessions match this filter',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          itemBuilder: (context, index) =>
              BxCongressAgendaSessionCard(session: sessions[index]),
        );
      },
    );
  }
}
