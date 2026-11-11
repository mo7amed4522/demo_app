// File: lib/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_event.dart
// Architecture: Presentation Layer - Home Tab Controller
// Purpose: Define events for the home tab UI

part of 'bx_home_tab_controller_bloc.dart';

abstract class BxHomeTabControllerEvent extends Equatable {
  const BxHomeTabControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxHomeTabLoadRequested extends BxHomeTabControllerEvent {}

class BxHomeTabSearchChanged extends BxHomeTabControllerEvent {
  final String query;
  const BxHomeTabSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
