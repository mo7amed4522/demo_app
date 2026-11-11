// File: lib/presentation/widgets/bx_speakers_widget/widgets/bx_speakers_search_bar.dart
// Architecture: Presentation Layer - Speakers Widgets
// Purpose: Inline search field wired to the BLoC

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxSpeakersSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const BxSpeakersSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (val) => context.read<BxSpeakersControllerBloc>().add(
        BxSpeakersSearchChanged(val),
      ),
      decoration: InputDecoration(
        hintText: 'Search speakers',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade400,
          size: 20.sp,
        ),
        suffixIcon: Icon(Icons.tune, color: BxAppColors.primary, size: 20.sp),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
      ),
    );
  }
}
