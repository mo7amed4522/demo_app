// File: lib/presentation/bloc/bx_theme_controller/bx_theme_controller_event.dart
// Architecture: Presentation Layer - Theme Controller
// Purpose: Define events for theme controller BLoC
part of 'bx_theme_controller_bloc.dart';

abstract class BxThemeControllerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BxLoadThemeEvent extends BxThemeControllerEvent {}

class BxChangeThemeEvent extends BxThemeControllerEvent {
  final ThemeMode themeMode;

  BxChangeThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}
