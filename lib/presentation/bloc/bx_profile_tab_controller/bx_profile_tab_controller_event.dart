// File: lib/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_event.dart
part of 'bx_profile_tab_controller_bloc.dart';

abstract class BxProfileTabControllerEvent extends Equatable {
  const BxProfileTabControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxProfileTabLoadRequested extends BxProfileTabControllerEvent {}
