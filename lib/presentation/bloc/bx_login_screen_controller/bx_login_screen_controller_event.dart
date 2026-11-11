// File: lib/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_event.dart
// Architecture: Presentation Layer - Login Screen Controller
// Purpose: Define events for login screen controller BLoC
part of 'bx_login_screen_controller_bloc.dart';

abstract class BxLoginScreenControllerEvent extends Equatable {
  const BxLoginScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxEmailChanged extends BxLoginScreenControllerEvent {
  final String email;

  const BxEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class BxPasswordChanged extends BxLoginScreenControllerEvent {
  final String password;

  const BxPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class BxTogglePasswordVisibility extends BxLoginScreenControllerEvent {}

class BxLoginSubmitted extends BxLoginScreenControllerEvent {}
