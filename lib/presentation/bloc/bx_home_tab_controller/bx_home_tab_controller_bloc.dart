// File: lib/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_bloc.dart
// Architecture: Presentation Layer - Home Tab Controller
// Purpose: BLoC for managing the home tab content

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_home_tab_controller_event.dart';
part 'bx_home_tab_controller_state.dart';

class BxHomeTabControllerBloc
    extends Bloc<BxHomeTabControllerEvent, BxHomeTabControllerState> {
  BxHomeTabControllerBloc() : super(const BxHomeTabControllerState()) {
    on<BxHomeTabLoadRequested>(_onLoadRequested);
    on<BxHomeTabSearchChanged>(_onSearchChanged);
  }

  Future<void> _onLoadRequested(
    BxHomeTabLoadRequested event,
    Emitter<BxHomeTabControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxHomeTabStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: BxHomeTabStatus.success));
  }

  void _onSearchChanged(
    BxHomeTabSearchChanged event,
    Emitter<BxHomeTabControllerState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
