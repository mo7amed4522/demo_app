// File: lib/presentation/widgets/bx_name_tag_widget/bx_name_tag_widget_mobile.dart
// Architecture: Presentation Layer - Name Tag Shell
// Purpose: Mobile shell — header + scrollable badge card

import 'package:demo_app/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_badge_card.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagWidgetMobile extends StatelessWidget {
  const BxNameTagWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxNameTagHeader(
              onBack: () => Navigator.pop(context),
              onPrint: () => context.read<BxNameTagControllerBloc>().add(
                BxNameTagPrintRequested(),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Badge card
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: const BxNameTagBadgeCard(),
            ),
          ),
        ],
      ),
    );
  }
}
