// File: lib/presentation/widgets/bx_ask_qa_widget/bx_ask_qa_widget_tablet.dart
// Architecture: Presentation Layer - Ask Q&A Shell
// Purpose: Tablet shell — wider padding, capped content width

import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_banner.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_header.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_input_card.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_question_list.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_sort_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaWidgetTablet extends StatelessWidget {
  const BxAskQaWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxAskQaControllerBloc>();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 16.h),
            child: BxAskQaHeader(onBack: () => Navigator.pop(context)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: const BxAskQaBanner(),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 32.h),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 900.w),
                    child: Column(
                      children: [
                        BxAskQaInputCard(controller: bloc.questionController),
                        SizedBox(height: 24.h),
                        const BxAskQaSortTabs(),
                        SizedBox(height: 24.h),
                        const BxAskQaQuestionList(),
                        SizedBox(height: 48.h),
                      ],
                    ),
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
