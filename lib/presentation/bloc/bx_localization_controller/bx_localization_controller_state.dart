// File: lib/presentation/bloc/bx_localization_controller/bx_localization_controller_state.dart
// Architecture: Presentation Layer - Localization Controller
// Purpose: Define states for localization controller BLoC

part of 'bx_localization_controller_bloc.dart';

enum BxLocalizationStatus { initial, loading, success, error }

class BxLocalizationControllerState extends Equatable {
  final BxLocalizationStatus status;
  final String? error;
  final String languageCode;

  const BxLocalizationControllerState({
    this.status = BxLocalizationStatus.initial,
    this.error,
    this.languageCode = 'en',
  });

  BxLocalizationControllerState copyWith({
    BxLocalizationStatus? status,
    String? error,
    String? languageCode,
  }) {
    return BxLocalizationControllerState(
      status: status ?? this.status,
      error: error ?? this.error,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [status, error, languageCode];
}
