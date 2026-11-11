// File: lib/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_event.dart
// Architecture: Presentation Layer - Register Screen Controller
// Purpose: Define events for register screen controller BLoC
part of 'bx_register_screen_controller_bloc.dart';

abstract class BxRegisterScreenControllerEvent extends Equatable {
  const BxRegisterScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxRegisterNameChanged extends BxRegisterScreenControllerEvent {
  final String name;
  const BxRegisterNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class BxRegisterEmailChanged extends BxRegisterScreenControllerEvent {
  final String email;
  const BxRegisterEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class BxRegisterHospitalChanged extends BxRegisterScreenControllerEvent {
  final String hospital;
  const BxRegisterHospitalChanged(this.hospital);
  @override
  List<Object?> get props => [hospital];
}

class BxRegisterPasswordChanged extends BxRegisterScreenControllerEvent {
  final String password;
  const BxRegisterPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class BxRegisterTogglePasswordVisibility
    extends BxRegisterScreenControllerEvent {}

class BxRegisterToggleTerms extends BxRegisterScreenControllerEvent {}

class BxRegisterSubmitted extends BxRegisterScreenControllerEvent {}
