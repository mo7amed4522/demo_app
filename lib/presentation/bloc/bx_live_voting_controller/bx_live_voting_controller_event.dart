// File: lib/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_event.dart
// Architecture: Presentation Layer - Live Voting Controller
// Purpose: Events for live voting controller BLoC

part of 'bx_live_voting_controller_bloc.dart';

abstract class BxLiveVotingControllerEvent extends Equatable {
  const BxLiveVotingControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxLiveVotingLoadRequested extends BxLiveVotingControllerEvent {}

class BxLiveVotingOptionSelected extends BxLiveVotingControllerEvent {
  final int optionIndex;

  const BxLiveVotingOptionSelected(this.optionIndex);

  @override
  List<Object?> get props => [optionIndex];
}

class BxLiveVotingPreviousPoll extends BxLiveVotingControllerEvent {}

class BxLiveVotingNextPoll extends BxLiveVotingControllerEvent {}

class BxLiveVotingNextPollButtonTapped extends BxLiveVotingControllerEvent {}

class BxLiveVotingPollChanged extends BxLiveVotingControllerEvent {
  final int pollIndex;

  const BxLiveVotingPollChanged(this.pollIndex);

  @override
  List<Object?> get props => [pollIndex];
}
