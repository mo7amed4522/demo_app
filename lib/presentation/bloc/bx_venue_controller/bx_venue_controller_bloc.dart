// File: lib/presentation/bloc/bx_venue_controller/bx_venue_controller_bloc.dart
// Architecture: Presentation Layer - Venue Controller
// Purpose: BLoC managing venue lifecycle and navigation actions

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_venue_controller_event.dart';
part 'bx_venue_controller_state.dart';

class BxVenueControllerBloc
    extends Bloc<BxVenueControllerEvent, BxVenueControllerState> {
  BxVenueControllerBloc() : super(const BxVenueControllerState()) {
    on<BxVenueLoadRequested>(_onLoadRequested);
    on<BxVenueNavigateRequested>(_onNavigateRequested);
    on<BxVenueMapTapped>(_onMapTapped);
  }

  Future<void> _onLoadRequested(
    BxVenueLoadRequested event,
    Emitter<BxVenueControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxVenueStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      emit(state.copyWith(status: BxVenueStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: BxVenueStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onNavigateRequested(
    BxVenueNavigateRequested event,
    Emitter<BxVenueControllerState> emit,
  ) async {
    debugPrint('Navigate requested for: ${state.venueAddress}');
  }

  Future<void> _onMapTapped(
    BxVenueMapTapped event,
    Emitter<BxVenueControllerState> emit,
  ) async {
    debugPrint('Map preview tapped: ${state.venueName}');
  }
}
