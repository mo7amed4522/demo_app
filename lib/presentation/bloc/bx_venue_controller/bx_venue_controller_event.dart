// File: lib/presentation/bloc/bx_venue_controller/bx_venue_controller_event.dart
// Architecture: Presentation Layer - Venue Controller
// Purpose: Events for venue controller BLoC

part of 'bx_venue_controller_bloc.dart';

abstract class BxVenueControllerEvent extends Equatable {
  const BxVenueControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxVenueLoadRequested extends BxVenueControllerEvent {}

class BxVenueNavigateRequested extends BxVenueControllerEvent {}

class BxVenueMapTapped extends BxVenueControllerEvent {}
