// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_state.dart
// Architecture: Presentation Layer - Bx Splash Screen Controller
// Purpose: Define states for splash screen controller BLoC

// ignore_for_file: must_be_immutable

part of 'bx_splash_screen_controller_bloc.dart';

enum BxSplashScreenStatus { initial, loading, success, error }

class BxSplashScreenControllerState extends Equatable {
  final BxSplashScreenStatus status;
  final String? errorMessage;

  const BxSplashScreenControllerState({
    this.status = BxSplashScreenStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  BxSplashScreenControllerState copyWith({
    BxSplashScreenStatus? status,
    String? errorMessage,
  }) {
    return BxSplashScreenControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
