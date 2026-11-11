// File: lib/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_event.dart
// Architecture: Presentation Layer - Congress Agenda Controller
// Purpose: Events for congress agenda controller BLoC

part of 'bx_congress_agenda_controller_bloc.dart';

abstract class BxCongressAgendaControllerEvent extends Equatable {
  const BxCongressAgendaControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxCongressAgendaLoadRequested extends BxCongressAgendaControllerEvent {}

class BxCongressAgendaDayChanged extends BxCongressAgendaControllerEvent {
  final int dayIndex;

  const BxCongressAgendaDayChanged(this.dayIndex);

  @override
  List<Object?> get props => [dayIndex];
}

class BxCongressAgendaFilterChanged extends BxCongressAgendaControllerEvent {
  final int filterIndex;

  const BxCongressAgendaFilterChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}

class BxCongressAgendaBookmarkToggled extends BxCongressAgendaControllerEvent {
  final String sessionTitle;

  const BxCongressAgendaBookmarkToggled(this.sessionTitle);

  @override
  List<Object?> get props => [sessionTitle];
}

class BxCongressAgendaResetRequested extends BxCongressAgendaControllerEvent {}
