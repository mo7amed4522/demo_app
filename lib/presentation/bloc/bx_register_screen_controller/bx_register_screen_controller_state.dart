// File: lib/presentation/bloc/bx_register_screen_controller/bx_register_screen_controller_state.dart
// Architecture: Presentation Layer - Register Screen Controller
// Purpose: Define states for register screen controller BLoC
part of 'bx_register_screen_controller_bloc.dart';

enum BxRegisterStatus { initial, loading, success, failure }

class BxRegisterScreenControllerState extends Equatable {
  final String name;
  final String email;
  final String hospital;
  final String password;
  final bool isPasswordVisible;
  final bool isTermsAccepted;
  final BxRegisterStatus status;
  final String? errorMessage;

  const BxRegisterScreenControllerState({
    this.name = '',
    this.email = '',
    this.hospital = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isTermsAccepted = false,
    this.status = BxRegisterStatus.initial,
    this.errorMessage,
  });

  BxRegisterScreenControllerState copyWith({
    String? name,
    String? email,
    String? hospital,
    String? password,
    bool? isPasswordVisible,
    bool? isTermsAccepted,
    BxRegisterStatus? status,
    String? errorMessage,
  }) {
    return BxRegisterScreenControllerState(
      name: name ?? this.name,
      email: email ?? this.email,
      hospital: hospital ?? this.hospital,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    hospital,
    password,
    isPasswordVisible,
    isTermsAccepted,
    status,
    errorMessage,
  ];
}
