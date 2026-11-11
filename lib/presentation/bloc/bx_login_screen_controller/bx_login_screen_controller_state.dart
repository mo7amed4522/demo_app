// File: lib/presentation/bloc/bx_login_screen_controller/bx_login_screen_controller_state.dart
// Architecture: Presentation Layer - Login Screen Controller
// Purpose: Define states for login screen controller BLoC
part of 'bx_login_screen_controller_bloc.dart';

enum BxLoginStatus { initial, loading, success, failure }

class BxLoginScreenControllerState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final BxLoginStatus status;
  final String? errorMessage;

  const BxLoginScreenControllerState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.status = BxLoginStatus.initial,
    this.errorMessage,
  });

  BxLoginScreenControllerState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    BxLoginStatus? status,
    String? errorMessage,
  }) {
    return BxLoginScreenControllerState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isPasswordVisible,
    status,
    errorMessage,
  ];
}
