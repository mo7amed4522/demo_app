// File: lib/presentation/bloc/bx_profile_tab_controller/bx_profile_tab_controller_state.dart
part of 'bx_profile_tab_controller_bloc.dart';

enum BxProfileTabStatus { initial, loading, success, error }

class BxProfileTabControllerState extends Equatable {
  final BxProfileTabStatus status;
  final String name;
  final String role;
  final String id;
  final String email;
  final String phone;
  final String location;
  final int sessionsCount;
  final int savedCount;
  final int certificatesCount;

  const BxProfileTabControllerState({
    this.status = BxProfileTabStatus.initial,
    this.name = 'Huda Latheef',
    this.role = 'Medical Congress Attendee',
    this.id = 'NMC-2026-001',
    this.email = 'huda@example.com',
    this.phone = '+971 56 283 4212',
    this.location = 'Dubai, UAE',
    this.sessionsCount = 12,
    this.savedCount = 5,
    this.certificatesCount = 3,
  });

  BxProfileTabControllerState copyWith({
    BxProfileTabStatus? status,
    String? name,
    String? role,
    String? id,
    String? email,
    String? phone,
    String? location,
    int? sessionsCount,
    int? savedCount,
    int? certificatesCount,
  }) {
    return BxProfileTabControllerState(
      status: status ?? this.status,
      name: name ?? this.name,
      role: role ?? this.role,
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      sessionsCount: sessionsCount ?? this.sessionsCount,
      savedCount: savedCount ?? this.savedCount,
      certificatesCount: certificatesCount ?? this.certificatesCount,
    );
  }

  @override
  List<Object?> get props => [
    status,
    name,
    role,
    id,
    email,
    phone,
    location,
    sessionsCount,
    savedCount,
    certificatesCount,
  ];
}
