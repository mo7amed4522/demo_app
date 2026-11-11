// File: lib/presentation/bloc/bx_resources_controller/bx_resources_controller_bloc.dart
// Architecture: Presentation Layer - Resources Controller
// Purpose: BLoC managing resources lifecycle, filter, search, bookmark, download

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_resources_controller_event.dart';
part 'bx_resources_controller_state.dart';

class BxResourcesControllerBloc
    extends Bloc<BxResourcesControllerEvent, BxResourcesControllerState> {
  final TextEditingController searchController = TextEditingController();

  BxResourcesControllerBloc() : super(const BxResourcesControllerState()) {
    on<BxResourcesLoadRequested>(_onLoadRequested);
    on<BxResourcesFilterChanged>(_onFilterChanged);
    on<BxResourcesSearchChanged>(_onSearchChanged);
    on<BxResourcesBookmarkToggled>(_onBookmarkToggled);
    on<BxResourcesDownloadToggled>(_onDownloadToggled);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  Future<void> _onLoadRequested(
    BxResourcesLoadRequested event,
    Emitter<BxResourcesControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxResourcesStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: BxResourcesStatus.success,
          allResources: BxResourcesControllerState.defaultResources,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxResourcesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterChanged(
    BxResourcesFilterChanged event,
    Emitter<BxResourcesControllerState> emit,
  ) {
    if (event.filterIndex == state.selectedFilterIndex) return;
    emit(state.copyWith(selectedFilterIndex: event.filterIndex));
  }

  void _onSearchChanged(
    BxResourcesSearchChanged event,
    Emitter<BxResourcesControllerState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onBookmarkToggled(
    BxResourcesBookmarkToggled event,
    Emitter<BxResourcesControllerState> emit,
  ) {
    final updated = state.allResources.map((item) {
      if (item.title == event.title) {
        return item.copyWith(isSaved: !item.isSaved);
      }
      return item;
    }).toList();

    emit(state.copyWith(allResources: updated));
  }

  void _onDownloadToggled(
    BxResourcesDownloadToggled event,
    Emitter<BxResourcesControllerState> emit,
  ) {
    final updated = state.allResources.map((item) {
      if (item.title == event.title) {
        return item.copyWith(isDownloaded: !item.isDownloaded);
      }
      return item;
    }).toList();

    emit(state.copyWith(allResources: updated));
  }
}
