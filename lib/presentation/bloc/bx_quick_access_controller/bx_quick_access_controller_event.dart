// File: lib/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_event.dart
// Architecture: Presentation Layer - Quick Access Controller
// Purpose: Events for quick access controller BLoC

part of 'bx_quick_access_controller_bloc.dart';

abstract class BxQuickAccessControllerEvent extends Equatable {
  const BxQuickAccessControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxQuickAccessLoadRequested extends BxQuickAccessControllerEvent {}

class BxQuickAccessFilterChanged extends BxQuickAccessControllerEvent {
  final int filterIndex;

  const BxQuickAccessFilterChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}

class BxQuickAccessSearchChanged extends BxQuickAccessControllerEvent {
  final String query;

  const BxQuickAccessSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
