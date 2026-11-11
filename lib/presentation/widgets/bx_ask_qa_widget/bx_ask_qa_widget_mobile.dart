// File: lib/presentation/widgets/bx_ask_qa_widget/bx_ask_qa_widget_mobile.dart
// Architecture: Presentation Layer - Ask Q&A Shell
// Purpose: Mobile shell — header + banner + white sheet (input + tabs + list)

import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_banner.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_header.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_input_card.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_question_list.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_sort_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaWidgetMobile extends StatelessWidget {
  const BxAskQaWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxAskQaControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: BxAskQaHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 12.h),

          // Banner
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const BxAskQaBanner(),
          ),
          SizedBox(height: 24.h),

          // White sheet
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    // Input card
                    BxAskQaInputCard(controller: bloc.questionController),
                    SizedBox(height: 20.h),

                    // Sort tabs
                    const BxAskQaSortTabs(),
                    SizedBox(height: 20.h),

                    // Question list
                    const BxAskQaQuestionList(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
