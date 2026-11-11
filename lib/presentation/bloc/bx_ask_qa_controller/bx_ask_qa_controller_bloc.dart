// File: lib/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_bloc.dart
// Architecture: Presentation Layer - Ask Q&A Controller
// Purpose: BLoC managing ask Q&A lifecycle, category, sort, submit, upvote

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_ask_qa_controller_event.dart';
part 'bx_ask_qa_controller_state.dart';

class BxAskQaControllerBloc
    extends Bloc<BxAskQaControllerEvent, BxAskQaControllerState> {
  final TextEditingController questionController = TextEditingController();

  BxAskQaControllerBloc() : super(const BxAskQaControllerState()) {
    on<BxAskQaLoadRequested>(_onLoadRequested);
    on<BxAskQaCategoryChanged>(_onCategoryChanged);
    on<BxAskQaSortChanged>(_onSortChanged);
    on<BxAskQaSubmitted>(_onSubmitted);
    on<BxAskQaUpvoted>(_onUpvoted);
  }

  @override
  Future<void> close() {
    questionController.dispose();
    return super.close();
  }

  Future<void> _onLoadRequested(
    BxAskQaLoadRequested event,
    Emitter<BxAskQaControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxAskQaStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: BxAskQaStatus.success,
          allQuestions: BxAskQaControllerState.defaultQuestions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BxAskQaStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onCategoryChanged(
    BxAskQaCategoryChanged event,
    Emitter<BxAskQaControllerState> emit,
  ) {
    if (event.categoryIndex == state.selectedCategoryIndex) return;
    emit(state.copyWith(selectedCategoryIndex: event.categoryIndex));
  }

  void _onSortChanged(
    BxAskQaSortChanged event,
    Emitter<BxAskQaControllerState> emit,
  ) {
    if (event.sortIndex == state.selectedSortIndex) return;
    emit(state.copyWith(selectedSortIndex: event.sortIndex));
  }

  void _onSubmitted(
    BxAskQaSubmitted event,
    Emitter<BxAskQaControllerState> emit,
  ) {
    final text = questionController.text.trim();
    if (text.isEmpty) return;

    final category =
        BxAskQaControllerState.categories[state.selectedCategoryIndex];

    final newQuestion = BxQaQuestion(
      upvotes: 0,
      category: category,
      status: 'Open',
      question: text,
      speaker: 'You',
      initials: 'Y',
    );

    emit(state.copyWith(allQuestions: [newQuestion, ...state.allQuestions]));

    questionController.clear();
  }

  void _onUpvoted(BxAskQaUpvoted event, Emitter<BxAskQaControllerState> emit) {
    final current = state.visibleQuestions;
    if (event.questionIndex < 0 || event.questionIndex >= current.length) {
      return;
    }

    final target = current[event.questionIndex];
    final updated = state.allQuestions
        .map(
          (q) => q.question == target.question && q.speaker == target.speaker
              ? q.copyWith(upvotes: q.upvotes + 1)
              : q,
        )
        .toList();

    emit(state.copyWith(allQuestions: updated));
  }
}
