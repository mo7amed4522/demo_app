// File: lib/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_question_list.dart
// Architecture: Presentation Layer - Ask Q&A Widgets
// Purpose: State-aware question list (loading / error / empty / success)

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:demo_app/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaQuestionList extends StatelessWidget {
  const BxAskQaQuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxAskQaControllerBloc, BxAskQaControllerState>(
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.selectedSortIndex != curr.selectedSortIndex ||
          prev.allQuestions != curr.allQuestions,
      builder: (context, state) {
        // --- Loading ---
        if (state.status == BxAskQaStatus.initial ||
            state.status == BxAskQaStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Center(
              child: CircularProgressIndicator(color: BxAppColors.primary),
            ),
          );
        }

        // --- Error ---
        if (state.status == BxAskQaStatus.error) {
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
                  onPressed: () => context.read<BxAskQaControllerBloc>().add(
                    BxAskQaLoadRequested(),
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
        final questions = state.visibleQuestions;

        if (questions.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Center(
              child: Text(
                'No questions yet',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          itemBuilder: (context, index) => BxAskQaQuestionCard(
            question: questions[index],
            onUpvote: () => context.read<BxAskQaControllerBloc>().add(
              BxAskQaUpvoted(index),
            ),
            onReply: () {
              // Placeholder — wire to a reply sheet in the real app.
            },
          ),
        );
      },
    );
  }
}
