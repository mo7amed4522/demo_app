// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_event.dart
// Architecture: Presentation Layer - Splash Screen Controller
// Purpose: Define events for splash screen controller BLoC
part of 'bx_splash_screen_controller_bloc.dart';

abstract class BxSplashScreenControllerEvent extends Equatable {
  const BxSplashScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxStartSplashTimer extends BxSplashScreenControllerEvent {
  const BxStartSplashTimer();

  @override
  List<Object?> get props => [];
}

class BxResetSplashScreen extends BxSplashScreenControllerEvent {
  const BxResetSplashScreen();

  @override
  List<Object?> get props => [];
}
