// File: lib/presentation/bloc/theme_controller/theme_controller_bloc.dart
// Architecture: Presentation Layer - Theme Controller
// Purpose: BLoC for managing theme state and persistence

import 'package:demo_app/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'bx_theme_controller_event.dart';
part 'bx_theme_controller_state.dart';

class BxThemeControllerBloc
    extends Bloc<BxThemeControllerEvent, BxThemeControllerState> {
  final BxSharedPreferencesDataSource _bxSharedPreferencesDataSource;

  BxThemeControllerBloc(this._bxSharedPreferencesDataSource)
    : super(const BxThemeControllerState()) {
    on<BxLoadThemeEvent>(_onLoadTheme);
    on<BxChangeThemeEvent>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(
    BxLoadThemeEvent event,
    Emitter<BxThemeControllerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BxThemeStatus.loading));

      final savedThemeMode = await _bxSharedPreferencesDataSource
          .getThemeMode();
      final themeMode = _parseThemeMode(savedThemeMode);

      emit(state.copyWith(status: BxThemeStatus.success, themeMode: themeMode));
    } catch (e) {
      emit(state.copyWith(status: BxThemeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onChangeTheme(
    BxChangeThemeEvent event,
    Emitter<BxThemeControllerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BxThemeStatus.loading));

      await _bxSharedPreferencesDataSource.saveThemeMode(
        _themeModeToString(event.themeMode),
      );

      emit(
        state.copyWith(
          status: BxThemeStatus.success,
          themeMode: event.themeMode,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BxThemeStatus.error, error: e.toString()));
    }
  }

  ThemeMode _parseThemeMode(String? themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark; // Default to dark
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
