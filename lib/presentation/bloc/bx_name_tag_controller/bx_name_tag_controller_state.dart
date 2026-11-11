// File: lib/presentation/bloc/bx_name_tag_controller/bx_name_tag_controller_state.dart
// Architecture: Presentation Layer - Name Tag Controller
// Purpose: State for name tag controller BLoC

part of 'bx_name_tag_controller_bloc.dart';

enum BxNameTagStatus { initial, loading, success, error }

class BxNameTagControllerState extends Equatable {
  final BxNameTagStatus status;

  final String congressTitle;
  final String congressSubtitle;
  final String initials;
  final String fullName;
  final String role;
  final String badgeId;
  final String location;
  final String congressDate;

  final String? errorMessage;

  const BxNameTagControllerState({
    this.status = BxNameTagStatus.initial,
    this.congressTitle = 'NESTLÉ MEDICAL',
    this.congressSubtitle = 'CONGRESS 2026',
    this.initials = 'HL',
    this.fullName = 'Huda Latheef',
    this.role = 'Flutter Developer • Attendee',
    this.badgeId = 'NMC-2026-001',
    this.location = 'Dubai, UAE',
    this.congressDate = '22 - 23 May 2026',
    this.errorMessage,
  });

  BxNameTagControllerState copyWith({
    BxNameTagStatus? status,
    String? congressTitle,
    String? congressSubtitle,
    String? initials,
    String? fullName,
    String? role,
    String? badgeId,
    String? location,
    String? congressDate,
    String? errorMessage,
  }) {
    return BxNameTagControllerState(
      status: status ?? this.status,
      congressTitle: congressTitle ?? this.congressTitle,
      congressSubtitle: congressSubtitle ?? this.congressSubtitle,
      initials: initials ?? this.initials,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      badgeId: badgeId ?? this.badgeId,
      location: location ?? this.location,
      congressDate: congressDate ?? this.congressDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    congressTitle,
    congressSubtitle,
    initials,
    fullName,
    role,
    badgeId,
    location,
    congressDate,
    errorMessage,
  ];
}
