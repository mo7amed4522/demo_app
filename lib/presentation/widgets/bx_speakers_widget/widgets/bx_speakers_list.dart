// File: lib/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_list.dart
// Architecture: Presentation Layer - Speakers Widgets
// Purpose: State-aware list (loading / error / empty / success)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSpeakersList extends StatelessWidget {
  const BxSpeakersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxSpeakersControllerBloc, BxSpeakersControllerState>(
      // Rebuild only when status, filter, search or list changes.
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.selectedFilterIndex != curr.selectedFilterIndex ||
          prev.searchQuery != curr.searchQuery ||
          prev.allSpeakers != curr.allSpeakers,
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxSpeakersStatus.initial ||
            state.status == BxSpeakersStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Center(
              child: CircularProgressIndicator(color: BxAppColors.primary),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxSpeakersStatus.error) {
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
                  onPressed: () => context.read<BxSpeakersControllerBloc>().add(
                    BxSpeakersLoadRequested(),
                  ),
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
        final speakers = state.visibleSpeakers;

        if (speakers.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No speakers match your search',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: speakers.length,
          itemBuilder: (context, index) =>
              BxSpeakersCard(speaker: speakers[index]),
        );
      },
    );
  }
}
