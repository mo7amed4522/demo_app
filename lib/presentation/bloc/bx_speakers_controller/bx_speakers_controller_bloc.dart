// File: lib/presentation/bloc/bx_speakers_controller/bx_speakers_controller_bloc.dart
// Architecture: Presentation Layer - Speakers Controller
// Purpose: BLoC managing speakers lifecycle, filters, search and star toggles

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_speakers_controller_event.dart';
part 'bx_speakers_controller_state.dart';

class BxSpeakersControllerBloc
    extends Bloc<BxSpeakersControllerEvent, BxSpeakersControllerState> {
  final TextEditingController searchController = TextEditingController();

  BxSpeakersControllerBloc() : super(const BxSpeakersControllerState()) {
    on<BxSpeakersLoadRequested>(_onLoadRequested);
    on<BxSpeakersFilterChanged>(_onFilterChanged);
    on<BxSpeakersSearchChanged>(_onSearchChanged);
    on<BxSpeakersStarToggled>(_onStarToggled);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  Future<void> _onLoadRequested(
    BxSpeakersLoadRequested event,
    Emitter<BxSpeakersControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxSpeakersStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: BxSpeakersStatus.success,
          allSpeakers: BxSpeakersControllerState.defaultSpeakers,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxSpeakersStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterChanged(
    BxSpeakersFilterChanged event,
    Emitter<BxSpeakersControllerState> emit,
  ) {
    if (event.filterIndex == state.selectedFilterIndex) return;
    emit(state.copyWith(selectedFilterIndex: event.filterIndex));
  }

  void _onSearchChanged(
    BxSpeakersSearchChanged event,
    Emitter<BxSpeakersControllerState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onStarToggled(
    BxSpeakersStarToggled event,
    Emitter<BxSpeakersControllerState> emit,
  ) {
    final updated = state.allSpeakers.map((speaker) {
      if (speaker.name == event.speakerName) {
        return speaker.copyWith(isStarred: !speaker.isStarred);
      }
      return speaker;
    }).toList();

    emit(state.copyWith(allSpeakers: updated));
  }
}
