// File: lib/presentation/bloc/bx_venue_controller/bx_venue_controller_state.dart
// Architecture: Presentation Layer - Venue Controller
// Purpose: State for venue controller BLoC

part of 'bx_venue_controller_bloc.dart';

enum BxVenueStatus { initial, loading, success, error }

class BxVenueFacility extends Equatable {
  final IconData icon;
  final String label;

  const BxVenueFacility({required this.icon, required this.label});

  @override
  List<Object?> get props => [icon, label];
}

class BxVenueControllerState extends Equatable {
  final BxVenueStatus status;

  final String venueName;
  final String venueDate;
  final String venueAddressLabel;
  final String venueAddress;
  final String mapPreviewLabel;
  final List<BxVenueFacility> facilities;

  final String? errorMessage;

  const BxVenueControllerState({
    this.status = BxVenueStatus.initial,
    this.venueName = 'Dubai International Convention & Exhibition Center',
    this.venueDate = '22 - 23 May 2026',
    this.venueAddressLabel = 'Venue Address',
    this.venueAddress = 'World Trade Centre, Dubai,\nUnited Arab Emirates',
    this.mapPreviewLabel = 'Map Preview',
    this.facilities = defaultFacilities,
    this.errorMessage,
  });

  static const List<BxVenueFacility> defaultFacilities = [
    BxVenueFacility(icon: Icons.wifi, label: 'Free Wi-Fi'),
    BxVenueFacility(icon: Icons.local_parking, label: 'Parking'),
    BxVenueFacility(icon: Icons.restaurant, label: 'Catering'),
    BxVenueFacility(icon: Icons.accessible, label: 'Accessible'),
  ];

  BxVenueControllerState copyWith({
    BxVenueStatus? status,
    String? venueName,
    String? venueDate,
    String? venueAddressLabel,
    String? venueAddress,
    String? mapPreviewLabel,
    List<BxVenueFacility>? facilities,
    String? errorMessage,
  }) {
    return BxVenueControllerState(
      status: status ?? this.status,
      venueName: venueName ?? this.venueName,
      venueDate: venueDate ?? this.venueDate,
      venueAddressLabel: venueAddressLabel ?? this.venueAddressLabel,
      venueAddress: venueAddress ?? this.venueAddress,
      mapPreviewLabel: mapPreviewLabel ?? this.mapPreviewLabel,
      facilities: facilities ?? this.facilities,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    venueName,
    venueDate,
    venueAddressLabel,
    venueAddress,
    mapPreviewLabel,
    facilities,
    errorMessage,
  ];
}
