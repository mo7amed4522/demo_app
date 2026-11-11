// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_state.dart
// Architecture: Presentation Layer - Bx Home Screen Controller
// Purpose: State for managing home bottom-nav active tab index

part of 'bx_home_screen_controller_bloc.dart';

enum BxHomeScreenControllerStatus { initial, loading, success, error }

class BxHomeScreenControllerState extends Equatable {
  final BxHomeScreenControllerStatus status;
  final int activeTabIndex;
  final String? errorMessage;

  const BxHomeScreenControllerState({
    this.status = BxHomeScreenControllerStatus.initial,
    this.activeTabIndex = 0,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, activeTabIndex, errorMessage];

  BxHomeScreenControllerState copyWith({
    BxHomeScreenControllerStatus? status,
    int? activeTabIndex,
    String? errorMessage,
  }) {
    return BxHomeScreenControllerState(
      status: status ?? this.status,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
