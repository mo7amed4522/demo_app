// File: lib/presentation/bloc/bx_localization_controller/bx_localization_controller_bloc.dart
// Architecture: Presentation Layer - Localization Controller
// Purpose: BLoC for managing localization state and persistence

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:demo_app/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'bx_localization_controller_event.dart';
part 'bx_localization_controller_state.dart';

class BxLocalizationControllerBloc
    extends Bloc<BxLocalizationControllerEvent, BxLocalizationControllerState> {
  final BxSharedPreferencesDataSource _bxSharedPreferencesDataSource;

  BxLocalizationControllerBloc(this._bxSharedPreferencesDataSource)
    : super(const BxLocalizationControllerState()) {
    on<BxLoadLocalizationEvent>(_onLoadLocalization);
    on<BxChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadLocalization(
    BxLoadLocalizationEvent event,
    Emitter<BxLocalizationControllerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BxLocalizationStatus.loading));

      final savedLanguageCode = await _bxSharedPreferencesDataSource
          .getLanguageCode();
      final languageCode = savedLanguageCode ?? 'en';
      BxAppData.langCode = languageCode;
      emit(
        state.copyWith(
          status: BxLocalizationStatus.success,
          languageCode: languageCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BxLocalizationStatus.error, error: e.toString()),
      );
    }
  }

  Future<void> _onChangeLanguage(
    BxChangeLanguageEvent event,
    Emitter<BxLocalizationControllerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BxLocalizationStatus.loading));
      await _bxSharedPreferencesDataSource.saveLanguageCode(event.languageCode);
      emit(
        state.copyWith(
          status: BxLocalizationStatus.success,
          languageCode: event.languageCode,
        ),
      );
      BxAppData.langCode = event.languageCode;
    } catch (e) {
      emit(
        state.copyWith(status: BxLocalizationStatus.error, error: e.toString()),
      );
    }
  }
}
