// File: lib/presentation/bloc/bx_theme_controller/bx_theme_controller_state.dart
// Architecture: Presentation Layer - Theme Controller
// Purpose: Define states for theme controller BLoC

part of 'bx_theme_controller_bloc.dart';

enum BxThemeStatus { initial, loading, success, error }

class BxThemeControllerState extends Equatable {
  final BxThemeStatus status;
  final String? error;
  final ThemeMode themeMode;

  const BxThemeControllerState({
    this.status = BxThemeStatus.initial,
    this.error,
    this.themeMode = ThemeMode.dark,
  });

  BxThemeControllerState copyWith({
    BxThemeStatus? status,
    String? error,
    ThemeMode? themeMode,
  }) {
    return BxThemeControllerState(
      status: status ?? this.status,
      error: error ?? this.error,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [status, error, themeMode];
}
