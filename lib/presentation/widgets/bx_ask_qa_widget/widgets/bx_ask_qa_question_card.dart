// File: lib/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_question_card.dart
// Architecture: Presentation Layer - Ask Q&A Widgets
// Purpose: A single question card (upvote + tags + text + speaker + reply)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaQuestionCard extends StatelessWidget {
  final BxQaQuestion question;
  final VoidCallback? onUpvote;
  final VoidCallback? onReply;

  const BxAskQaQuestionCard({
    super.key,
    required this.question,
    this.onUpvote,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final isAnswered = question.isAnswered;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isAnswered ? const Color(0xFFFDE8C4) : Colors.grey.shade200,
          width: isAnswered ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Upvote ---
          GestureDetector(
            onTap: onUpvote,
            child: Container(
              width: 40.w,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.grey.shade700,
                    size: 18.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${question.upvotes}',
                    style: TextStyle(
                      color: BxAppColors.onSurface,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // --- Content ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        question.category,
                        style: TextStyle(
                          color: BxAppColors.primary,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isAnswered
                            ? const Color(0xFFFFF8E1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        question.status,
                        style: TextStyle(
                          color: isAnswered
                              ? const Color(0xFFD4A017)
                              : Colors.grey.shade600,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Question text
                Text(
                  question.question,
                  style: TextStyle(
                    color: BxAppColors.onSurface,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),

                // Footer: speaker + reply
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE3F2FD),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              question.initials,
                              style: TextStyle(
                                color: BxAppColors.primary,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          question.speaker,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: onReply,
                      child: Row(
                        children: [
                          Icon(
                            Icons.reply,
                            color: Colors.grey.shade400,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Reply',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
