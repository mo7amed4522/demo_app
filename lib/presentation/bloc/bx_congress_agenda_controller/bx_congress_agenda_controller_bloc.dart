// File: lib/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_bloc.dart
// Architecture: Presentation Layer - Congress Agenda Controller
// Purpose: BLoC managing congress agenda lifecycle, day toggle, filters, bookmarks

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_congress_agenda_controller_event.dart';
part 'bx_congress_agenda_controller_state.dart';

class BxCongressAgendaControllerBloc
    extends
        Bloc<BxCongressAgendaControllerEvent, BxCongressAgendaControllerState> {
  BxCongressAgendaControllerBloc()
    : super(const BxCongressAgendaControllerState()) {
    on<BxCongressAgendaLoadRequested>(_onLoadRequested);
    on<BxCongressAgendaDayChanged>(_onDayChanged);
    on<BxCongressAgendaFilterChanged>(_onFilterChanged);
    on<BxCongressAgendaBookmarkToggled>(_onBookmarkToggled);
    on<BxCongressAgendaResetRequested>(_onResetRequested);
  }

  Future<void> _onLoadRequested(
    BxCongressAgendaLoadRequested event,
    Emitter<BxCongressAgendaControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxCongressAgendaStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));

      emit(
        state.copyWith(
          status: BxCongressAgendaStatus.success,
          allSessions: BxCongressAgendaControllerState.defaultSessions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxCongressAgendaStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onDayChanged(
    BxCongressAgendaDayChanged event,
    Emitter<BxCongressAgendaControllerState> emit,
  ) {
    if (event.dayIndex == state.selectedDayIndex) return;
    emit(state.copyWith(selectedDayIndex: event.dayIndex));
  }

  void _onFilterChanged(
    BxCongressAgendaFilterChanged event,
    Emitter<BxCongressAgendaControllerState> emit,
  ) {
    if (event.filterIndex == state.selectedFilterIndex) return;
    emit(state.copyWith(selectedFilterIndex: event.filterIndex));
  }

  void _onBookmarkToggled(
    BxCongressAgendaBookmarkToggled event,
    Emitter<BxCongressAgendaControllerState> emit,
  ) {
    final updated = state.allSessions.map((session) {
      if (session.title == event.sessionTitle) {
        return session.copyWith(isBookmarked: !session.isBookmarked);
      }
      return session;
    }).toList();

    emit(state.copyWith(allSessions: updated));
  }

  void _onResetRequested(
    BxCongressAgendaResetRequested event,
    Emitter<BxCongressAgendaControllerState> emit,
  ) {
    emit(state.copyWith(selectedFilterIndex: 0));
  }
}
