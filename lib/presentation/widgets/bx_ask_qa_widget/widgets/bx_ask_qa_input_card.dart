// File: lib/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_input_card.dart
// Architecture: Presentation Layer - Ask Q&A Widgets
// Purpose: Input card (text field + category chips + submit button)

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaInputCard extends StatelessWidget {
  final TextEditingController controller;

  const BxAskQaInputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write your question',
            style: TextStyle(
              color: BxAppColors.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),

          // Text field
          TextField(
            controller: controller,
            maxLines: 3,
            style: TextStyle(color: BxAppColors.onSurface, fontSize: 12.sp),
            decoration: InputDecoration(
              hintText: 'Type your question for the speaker...',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F7FA),
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
          SizedBox(height: 12.h),

          // Category chips
          const BxAskQaCategoryChips(),

          SizedBox(height: 16.h),

          // Submit button
          GestureDetector(
            onTap: () =>
                context.read<BxAskQaControllerBloc>().add(BxAskQaSubmitted()),
            child: Container(
              width: double.infinity,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00C6FF), Color(0xFF0056D2)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, color: Colors.white, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Submit Question',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
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

/// Isolated category-chip row so typing in the text field doesn't rebuild it.
class BxAskQaCategoryChips extends StatelessWidget {
  const BxAskQaCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxAskQaControllerBloc, BxAskQaControllerState>(
      buildWhen: (prev, curr) =>
          prev.selectedCategoryIndex != curr.selectedCategoryIndex,
      builder: (context, state) {
        return SizedBox(
          height: 32.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: BxAskQaControllerState.categories.length,
            itemBuilder: (context, index) {
              final isSelected = state.selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () => context.read<BxAskQaControllerBloc>().add(
                  BxAskQaCategoryChanged(index),
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? BxAppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? BxAppColors.primary
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    BxAskQaControllerState.categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      fontSize: 11.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
