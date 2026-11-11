// File: lib/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_bloc.dart
// Architecture: Presentation Layer - Quick Access Controller
// Purpose: BLoC managing quick access lifecycle, filters and search

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_quick_access_controller_event.dart';
part 'bx_quick_access_controller_state.dart';

class BxQuickAccessControllerBloc
    extends Bloc<BxQuickAccessControllerEvent, BxQuickAccessControllerState> {
  final TextEditingController searchController = TextEditingController();

  BxQuickAccessControllerBloc() : super(const BxQuickAccessControllerState()) {
    on<BxQuickAccessLoadRequested>(_onLoadRequested);
    on<BxQuickAccessFilterChanged>(_onFilterChanged);
    on<BxQuickAccessSearchChanged>(_onSearchChanged);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  Future<void> _onLoadRequested(
    BxQuickAccessLoadRequested event,
    Emitter<BxQuickAccessControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxQuickAccessStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: BxQuickAccessStatus.success,
          allItems: BxQuickAccessControllerState.defaultItems,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxQuickAccessStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterChanged(
    BxQuickAccessFilterChanged event,
    Emitter<BxQuickAccessControllerState> emit,
  ) {
    if (event.filterIndex == state.selectedFilterIndex) return;
    emit(state.copyWith(selectedFilterIndex: event.filterIndex));
  }

  void _onSearchChanged(
    BxQuickAccessSearchChanged event,
    Emitter<BxQuickAccessControllerState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
