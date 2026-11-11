// File: lib/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_bloc.dart
// Architecture: Presentation Layer - Register Screen Controller
// Purpose: BLoC for managing register screen state and form validation

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_register_screen_controller_event.dart';
part 'bx_register_screen_controller_state.dart';

class BxRegisterScreenControllerBloc
    extends
        Bloc<BxRegisterScreenControllerEvent, BxRegisterScreenControllerState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  BxRegisterScreenControllerBloc()
    : super(const BxRegisterScreenControllerState()) {
    on<BxRegisterNameChanged>(
      (event, emit) =>
          emit(state.copyWith(name: event.name, errorMessage: null)),
    );
    on<BxRegisterEmailChanged>(
      (event, emit) =>
          emit(state.copyWith(email: event.email, errorMessage: null)),
    );
    on<BxRegisterHospitalChanged>(
      (event, emit) =>
          emit(state.copyWith(hospital: event.hospital, errorMessage: null)),
    );
    on<BxRegisterPasswordChanged>(
      (event, emit) =>
          emit(state.copyWith(password: event.password, errorMessage: null)),
    );
    on<BxRegisterTogglePasswordVisibility>(
      (event, emit) =>
          emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible)),
    );
    on<BxRegisterToggleTerms>(
      (event, emit) =>
          emit(state.copyWith(isTermsAccepted: !state.isTermsAccepted)),
    );
    on<BxRegisterSubmitted>(_onRegisterSubmitted);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    hospitalController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> _onRegisterSubmitted(
    BxRegisterSubmitted event,
    Emitter<BxRegisterScreenControllerState> emit,
  ) async {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.hospital.isEmpty ||
        state.password.isEmpty) {
      emit(
        state.copyWith(
          status: BxRegisterStatus.failure,
          errorMessage: 'Please fill in all fields',
        ),
      );
      return;
    }
    if (!state.isTermsAccepted) {
      emit(
        state.copyWith(
          status: BxRegisterStatus.failure,
          errorMessage: 'Please accept the terms and conditions',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BxRegisterStatus.loading, errorMessage: null));

    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: BxRegisterStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: BxRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
