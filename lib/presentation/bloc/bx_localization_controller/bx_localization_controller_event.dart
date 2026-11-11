// File: lib/presentation/bloc/bx_localization_controller/bx_localization_controller_event.dart
// Architecture: Presentation Layer - Localization Controller
// Purpose: Define events for localization controller BLoC

part of 'bx_localization_controller_bloc.dart';

abstract class BxLocalizationControllerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BxLoadLocalizationEvent extends BxLocalizationControllerEvent {}

class BxChangeLanguageEvent extends BxLocalizationControllerEvent {
  final String languageCode;

  BxChangeLanguageEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class BxReloadAppWithNewLocalizationEvent
    extends BxLocalizationControllerEvent {
  final String languageCode;
  final dynamic context;

  BxReloadAppWithNewLocalizationEvent({
    required this.languageCode,
    required this.context,
  });

  @override
  List<Object?> get props => [languageCode, context];
}
