// File: lib/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_bloc.dart
// Architecture: Presentation Layer - Login Screen Controller
// Purpose: BLoC for managing login screen state and form validation

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_login_screen_controller_event.dart';
part 'bx_login_screen_controller_state.dart';

class BxLoginScreenControllerBloc
    extends Bloc<BxLoginScreenControllerEvent, BxLoginScreenControllerState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  BxLoginScreenControllerBloc() : super(const BxLoginScreenControllerState()) {
    on<BxEmailChanged>(_onEmailChanged);
    on<BxPasswordChanged>(_onPasswordChanged);
    on<BxTogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<BxLoginSubmitted>(_onLoginSubmitted);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void _onEmailChanged(
    BxEmailChanged event,
    Emitter<BxLoginScreenControllerState> emit,
  ) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(
    BxPasswordChanged event,
    Emitter<BxLoginScreenControllerState> emit,
  ) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onTogglePasswordVisibility(
    BxTogglePasswordVisibility event,
    Emitter<BxLoginScreenControllerState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> _onLoginSubmitted(
    BxLoginSubmitted event,
    Emitter<BxLoginScreenControllerState> emit,
  ) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(
          status: BxLoginStatus.failure,
          errorMessage: 'Please fill in all fields',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BxLoginStatus.loading, errorMessage: null));

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (state.email == 'admin' && state.password == '123456') {
        emit(state.copyWith(status: BxLoginStatus.success));
      } else {
        emit(
          state.copyWith(
            status: BxLoginStatus.failure,
            errorMessage: 'Invalid email or password',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxLoginStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
