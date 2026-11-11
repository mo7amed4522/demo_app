// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart
// Architecture: Presentation Layer - Bx Home Screen Controller
// Purpose: BLoC for managing home bottom navigation active tab index and PageController lifecycle

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_home_screen_controller_event.dart';
part 'bx_home_screen_controller_state.dart';

class BxHomeScreenControllerBloc
    extends Bloc<BxHomeScreenControllerEvent, BxHomeScreenControllerState> {
  static const int tabCount = 2;

  /// PageController owned by the bloc so the view can remain StatelessWidget.
  /// Disposed safely in [close].
  final PageController pageController = PageController();

  BxHomeScreenControllerBloc() : super(const BxHomeScreenControllerState()) {
    on<BxHomeScreenControllerTabChanged>(_onTabChanged);
    on<BxHomeScreenControllerRefreshed>(_onRefreshed);
  }

  void _onTabChanged(
    BxHomeScreenControllerTabChanged event,
    Emitter<BxHomeScreenControllerState> emit,
  ) {
    if (event.index < 0 || event.index >= tabCount) return;

    if (event.index == state.activeTabIndex) return;

    emit(state.copyWith(activeTabIndex: event.index));
  }

  Future<void> _onRefreshed(
    BxHomeScreenControllerRefreshed event,
    Emitter<BxHomeScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxHomeScreenControllerStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: BxHomeScreenControllerStatus.success));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
