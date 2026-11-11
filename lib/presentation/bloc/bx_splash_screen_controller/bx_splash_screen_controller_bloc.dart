// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart
// Architecture: Presentation Layer - Splash Screen Controller
// Purpose: BLoC for managing splash screen timer state

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_splash_screen_controller_state.dart';
part 'bx_splash_screen_controller_event.dart';

class BxSplashScreenControllerBloc
    extends Bloc<BxSplashScreenControllerEvent, BxSplashScreenControllerState> {
  BxSplashScreenControllerBloc()
    : super(const BxSplashScreenControllerState()) {
    on<BxStartSplashTimer>(_onStartSplashTimer);
    on<BxResetSplashScreen>(_onResetSplashScreen);
  }

  Future<void> _onStartSplashTimer(
    BxStartSplashTimer event,
    Emitter<BxSplashScreenControllerState> emit,
  ) async {
    debugPrint("Starting splash timer... Current state: ${state.status}");
    if (state.status == BxSplashScreenStatus.loading) {
      debugPrint("Splash timer already running");
      return;
    }

    try {
      emit(
        state.copyWith(
          status: BxSplashScreenStatus.loading,
          errorMessage: null,
        ),
      );

      await Future.delayed(const Duration(seconds: 3));
      debugPrint("Splash timer completed");
      emit(state.copyWith(status: BxSplashScreenStatus.success));
    } catch (e) {
      // Handle any errors
      emit(
        state.copyWith(
          status: BxSplashScreenStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResetSplashScreen(
    BxResetSplashScreen event,
    Emitter<BxSplashScreenControllerState> emit,
  ) async {
    debugPrint("Resetting splash screen");
    emit(const BxSplashScreenControllerState());
    add(const BxStartSplashTimer());
  }
}
