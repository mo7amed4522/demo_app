// File: lib/presentation/widgets/bx_ask_qa_widget/widgets/bx_ask_qa_sort_tabs.dart
// Architecture: Presentation Layer - Ask Q&A Widgets
// Purpose: Sort tabs row (Popular / Recent / Answered) — isolated rebuild

import 'package:demo_app/core/theme/bx_app_colors.dart';
import 'package:demo_app/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxAskQaSortTabs extends StatelessWidget {
  const BxAskQaSortTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxAskQaControllerBloc, BxAskQaControllerState>(
      buildWhen: (prev, curr) =>
          prev.selectedSortIndex != curr.selectedSortIndex,
      builder: (context, state) {
        return Row(
          children: List.generate(BxAskQaControllerState.sorts.length, (index) {
            final isSelected = state.selectedSortIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => context.read<BxAskQaControllerBloc>().add(
                  BxAskQaSortChanged(index),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? BxAppColors.accentGold : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? BxAppColors.accentGold
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Text(
                    BxAskQaControllerState.sorts[index],
                    style: TextStyle(
                      color: isSelected
                          ? BxAppColors.background
                          : Colors.grey.shade600,
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
