// File: lib/presentation/bloc/bx_home_tab_controller/bx_home_tab_controller_state.dart
// Architecture: Presentation Layer - Home Tab Controller
// Purpose: Define state for the home tab UI

part of 'bx_home_tab_controller_bloc.dart';

enum BxHomeTabStatus { initial, loading, success, error }

class BxHomeTabControllerState extends Equatable {
  final BxHomeTabStatus status;
  final String searchQuery;
  final String errorMessage;

  const BxHomeTabControllerState({
    this.status = BxHomeTabStatus.initial,
    this.searchQuery = '',
    this.errorMessage = '',
  });

  BxHomeTabControllerState copyWith({
    BxHomeTabStatus? status,
    String? searchQuery,
    String? errorMessage,
  }) {
    return BxHomeTabControllerState(
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, searchQuery, errorMessage];
}
