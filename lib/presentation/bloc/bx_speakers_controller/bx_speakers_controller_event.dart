// File: lib/presentation/bloc/bx_speakers_controller/bx_speakers_controller_event.dart
// Architecture: Presentation Layer - Speakers Controller
// Purpose: Events for speakers controller BLoC

part of 'bx_speakers_controller_bloc.dart';

abstract class BxSpeakersControllerEvent extends Equatable {
  const BxSpeakersControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxSpeakersLoadRequested extends BxSpeakersControllerEvent {}

class BxSpeakersFilterChanged extends BxSpeakersControllerEvent {
  final int filterIndex;

  const BxSpeakersFilterChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}

class BxSpeakersSearchChanged extends BxSpeakersControllerEvent {
  final String query;

  const BxSpeakersSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class BxSpeakersStarToggled extends BxSpeakersControllerEvent {
  final String speakerName;

  const BxSpeakersStarToggled(this.speakerName);

  @override
  List<Object?> get props => [speakerName];
}
