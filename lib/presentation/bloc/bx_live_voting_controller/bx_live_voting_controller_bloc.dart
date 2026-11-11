// File: lib/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_bloc.dart
// Architecture: Presentation Layer - Live Voting Controller
// Purpose: BLoC managing live voting lifecycle, poll navigation, option selection

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_live_voting_controller_event.dart';
part 'bx_live_voting_controller_state.dart';

class BxLiveVotingControllerBloc
    extends Bloc<BxLiveVotingControllerEvent, BxLiveVotingControllerState> {
  BxLiveVotingControllerBloc() : super(const BxLiveVotingControllerState()) {
    on<BxLiveVotingLoadRequested>(_onLoadRequested);
    on<BxLiveVotingOptionSelected>(_onOptionSelected);
    on<BxLiveVotingPreviousPoll>(_onPreviousPoll);
    on<BxLiveVotingNextPoll>(_onNextPoll);
    on<BxLiveVotingNextPollButtonTapped>(_onNextPollButtonTapped);
    on<BxLiveVotingPollChanged>(_onPollChanged);
  }

  Future<void> _onLoadRequested(
    BxLiveVotingLoadRequested event,
    Emitter<BxLiveVotingControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxLiveVotingStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));

      emit(
        state.copyWith(
          status: BxLiveVotingStatus.success,
          polls: BxLiveVotingControllerState.defaultPolls,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxLiveVotingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onOptionSelected(
    BxLiveVotingOptionSelected event,
    Emitter<BxLiveVotingControllerState> emit,
  ) {
    final currentPoll = state.activePoll;
    if (event.optionIndex < 0 ||
        event.optionIndex >= currentPoll.options.length) {
      return;
    }
    final updatedOptions = currentPoll.options
        .asMap()
        .entries
        .map(
          (entry) =>
              entry.value.copyWith(isSelected: entry.key == event.optionIndex),
        )
        .toList();

    final updatedPoll = currentPoll.copyWith(options: updatedOptions);
    final updatedPolls = List<BxPoll>.from(state.polls)
      ..[state.activePollIndex] = updatedPoll;

    emit(state.copyWith(polls: updatedPolls));
  }

  void _onPreviousPoll(
    BxLiveVotingPreviousPoll event,
    Emitter<BxLiveVotingControllerState> emit,
  ) {
    if (!state.canGoPrevious) return;
    emit(state.copyWith(activePollIndex: state.activePollIndex - 1));
  }

  void _onNextPoll(
    BxLiveVotingNextPoll event,
    Emitter<BxLiveVotingControllerState> emit,
  ) {
    if (!state.canGoNext) return;
    emit(state.copyWith(activePollIndex: state.activePollIndex + 1));
  }

  void _onNextPollButtonTapped(
    BxLiveVotingNextPollButtonTapped event,
    Emitter<BxLiveVotingControllerState> emit,
  ) {
    if (state.canGoNext) {
      emit(state.copyWith(activePollIndex: state.activePollIndex + 1));
    } else {
      emit(state.copyWith(activePollIndex: 0));
    }
  }

  void _onPollChanged(
    BxLiveVotingPollChanged event,
    Emitter<BxLiveVotingControllerState> emit,
  ) {
    if (event.pollIndex < 0 || event.pollIndex >= state.polls.length) {
      return;
    }
    if (event.pollIndex == state.activePollIndex) return;
    emit(state.copyWith(activePollIndex: event.pollIndex));
  }
}
