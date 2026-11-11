// File: lib/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_profile_tab_controller_event.dart';
part 'bx_profile_tab_controller_state.dart';

class BxProfileTabControllerBloc
    extends Bloc<BxProfileTabControllerEvent, BxProfileTabControllerState> {
  BxProfileTabControllerBloc() : super(const BxProfileTabControllerState()) {
    on<BxProfileTabLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    BxProfileTabLoadRequested event,
    Emitter<BxProfileTabControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxProfileTabStatus.loading));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(status: BxProfileTabStatus.success));
  }
}
