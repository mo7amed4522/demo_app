// File: lib/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_bloc.dart
// Architecture: Presentation Layer - Name Tag Controller
// Purpose: BLoC managing name tag lifecycle and print action

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_name_tag_controller_event.dart';
part 'bx_name_tag_controller_state.dart';

class BxNameTagControllerBloc
    extends Bloc<BxNameTagControllerEvent, BxNameTagControllerState> {
  BxNameTagControllerBloc() : super(const BxNameTagControllerState()) {
    on<BxNameTagLoadRequested>(_onLoadRequested);
    on<BxNameTagPrintRequested>(_onPrintRequested);
  }

  Future<void> _onLoadRequested(
    BxNameTagLoadRequested event,
    Emitter<BxNameTagControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxNameTagStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(status: BxNameTagStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: BxNameTagStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPrintRequested(
    BxNameTagPrintRequested event,
    Emitter<BxNameTagControllerState> emit,
  ) async {
    debugPrint('Print requested for badge ${state.badgeId}');
  }
}
