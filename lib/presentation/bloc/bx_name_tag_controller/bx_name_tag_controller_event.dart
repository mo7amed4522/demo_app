// File: lib/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_event.dart
// Architecture: Presentation Layer - Name Tag Controller
// Purpose: Events for name tag controller BLoC

part of 'bx_name_tag_controller_bloc.dart';

abstract class BxNameTagControllerEvent extends Equatable {
  const BxNameTagControllerEvent();

  @override
  List<Object?> get props => [];
}

/// Fires once on BLoC creation to load the badge.
class BxNameTagLoadRequested extends BxNameTagControllerEvent {}

/// Triggered when the user taps the print icon.
class BxNameTagPrintRequested extends BxNameTagControllerEvent {}
