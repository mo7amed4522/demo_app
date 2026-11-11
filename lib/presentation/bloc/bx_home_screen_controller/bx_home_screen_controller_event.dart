// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_event.dart
// Architecture: Presentation Layer - Bx Home Screen Controller
// Purpose: Events for managing home bottom-nav tab index and optional refresh

part of 'bx_home_screen_controller_bloc.dart';

abstract class BxHomeScreenControllerEvent extends Equatable {
  const BxHomeScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxHomeScreenControllerTabChanged extends BxHomeScreenControllerEvent {
  final int index;

  const BxHomeScreenControllerTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class BxHomeScreenControllerRefreshed extends BxHomeScreenControllerEvent {
  const BxHomeScreenControllerRefreshed();

  @override
  List<Object?> get props => [];
}
