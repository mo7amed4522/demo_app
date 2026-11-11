// File: lib/presentation/widgets/bx_speakers_widget/bx_speakers_widget_tablet.dart
// Architecture: Presentation Layer - Speakers Shell
// Purpose: Tablet shell — wider paddings, capped content width

import 'package:demo_app/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_banner.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_filter_chips.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_header.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_list.dart';
import 'package:demo_app/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSpeakersWidgetTablet extends StatelessWidget {
  const BxSpeakersWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxSpeakersControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxSpeakersHeader(onBack: () => Navigator.of(context).pop()),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: const BxSpeakersBanner(),
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
                    child: BxSpeakersSearchBar(
                      controller: bloc.searchController,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const BxSpeakersFilterChips(),
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
                          child: const BxSpeakersList(),
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
