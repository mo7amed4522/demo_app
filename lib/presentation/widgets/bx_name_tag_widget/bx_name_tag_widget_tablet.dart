// File: lib/presentation/widgets/bx_name_tag_widget/bx_name_tag_widget_tablet.dart
// Architecture: Presentation Layer - Name Tag Shell
// Purpose: Tablet shell — wider padding, capped content width, bigger badge

import 'package:demo_app/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_badge_card.dart';
import 'package:demo_app/presentation/widgets/bx_name_tag_widget/widgets/bx_name_tag_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxNameTagWidgetTablet extends StatelessWidget {
  const BxNameTagWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxNameTagHeader(
              onBack: () => Navigator.pop(context),
              onPrint: () => context.read<BxNameTagControllerBloc>().add(
                BxNameTagPrintRequested(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600.w),
                  child: const BxNameTagBadgeCard(
                    padding: 28,
                    nameFontSize: 26,
                    avatarSize: 110,
                    qrSize: 160,
                    qrIconSize: 110,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
