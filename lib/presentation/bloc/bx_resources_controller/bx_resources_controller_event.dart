// File: lib/presentation/bloc/bx_resources_controller/bx_resources_controller_event.dart
// Architecture: Presentation Layer - Resources Controller
// Purpose: Events for resources controller BLoC

part of 'bx_resources_controller_bloc.dart';

abstract class BxResourcesControllerEvent extends Equatable {
  const BxResourcesControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxResourcesLoadRequested extends BxResourcesControllerEvent {}

class BxResourcesFilterChanged extends BxResourcesControllerEvent {
  final int filterIndex;

  const BxResourcesFilterChanged(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}

class BxResourcesSearchChanged extends BxResourcesControllerEvent {
  final String query;

  const BxResourcesSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class BxResourcesBookmarkToggled extends BxResourcesControllerEvent {
  final String title;

  const BxResourcesBookmarkToggled(this.title);

  @override
  List<Object?> get props => [title];
}

class BxResourcesDownloadToggled extends BxResourcesControllerEvent {
  final String title;

  const BxResourcesDownloadToggled(this.title);

  @override
  List<Object?> get props => [title];
}
