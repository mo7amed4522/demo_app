// File: lib/presentation/bloc/bx_speakers_controller/bx_speakers_controller_state.dart
// Architecture: Presentation Layer - Speakers Controller
// Purpose: State for speakers controller BLoC

part of 'bx_speakers_controller_bloc.dart';

enum BxSpeakersStatus { initial, loading, success, error }

class BxSpeaker extends Equatable {
  final String initials;
  final Color initialsColor;
  final String tag;
  final Color tagColor;
  final String name;
  final String role;
  final String location;
  final String topic;
  final bool isFeatured;
  final bool isStarred;

  final String category;

  const BxSpeaker({
    required this.initials,
    required this.initialsColor,
    required this.tag,
    required this.tagColor,
    required this.name,
    required this.role,
    required this.location,
    required this.topic,
    required this.isFeatured,
    required this.isStarred,
    required this.category,
  });

  BxSpeaker copyWith({bool? isStarred}) {
    return BxSpeaker(
      initials: initials,
      initialsColor: initialsColor,
      tag: tag,
      tagColor: tagColor,
      name: name,
      role: role,
      location: location,
      topic: topic,
      isFeatured: isFeatured,
      isStarred: isStarred ?? this.isStarred,
      category: category,
    );
  }

  @override
  List<Object?> get props => [
    initials,
    initialsColor,
    tag,
    tagColor,
    name,
    role,
    location,
    topic,
    isFeatured,
    isStarred,
    category,
  ];
}

class BxSpeakersControllerState extends Equatable {
  static const List<String> filters = [
    'All',
    'Nutrition',
    'Research',
    'Pediatrics',
  ];

  static const List<BxSpeaker> defaultSpeakers = [
    BxSpeaker(
      initials: 'SJ',
      initialsColor: Color(0xFF00B4D8),
      tag: 'FEATURED SPEAKER',
      tagColor: Color(0xFFE6A81D),
      name: 'Dr. Sarah Johnson',
      role: 'Pediatric Nutrition Specialist',
      location: 'United Kingdom',
      topic: 'Future of Pediatric Nutrition',
      isFeatured: true,
      isStarred: true,
      category: 'Pediatrics',
    ),
    BxSpeaker(
      initials: 'HA',
      initialsColor: Color(0xFF0056D2),
      tag: 'SPEAKER',
      tagColor: Color(0xFF0056D2),
      name: 'Dr. Hassan Ali',
      role: 'Clinical Research Director',
      location: 'UAE',
      topic: 'Welcome & Introduction',
      isFeatured: false,
      isStarred: false,
      category: 'Research',
    ),
    BxSpeaker(
      initials: 'AK',
      initialsColor: Color(0xFF00B4D8),
      tag: 'SPEAKER',
      tagColor: Color(0xFF0056D2),
      name: 'Dr. Ahmed Khalid',
      role: 'Nutrition Specialist',
      location: 'Egypt',
      topic: 'The Next Era of Nutrition',
      isFeatured: false,
      isStarred: false,
      category: 'Nutrition',
    ),
  ];

  final BxSpeakersStatus status;
  final List<BxSpeaker> allSpeakers;
  final int selectedFilterIndex;
  final String searchQuery;
  final String? errorMessage;

  const BxSpeakersControllerState({
    this.status = BxSpeakersStatus.initial,
    this.allSpeakers = defaultSpeakers,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
    this.errorMessage,
  });

  List<BxSpeaker> get visibleSpeakers {
    final filter = filters[selectedFilterIndex];
    final query = searchQuery.trim().toLowerCase();

    return allSpeakers.where((speaker) {
      final matchesFilter = filter == 'All' || speaker.category == filter;
      final matchesQuery =
          query.isEmpty ||
          speaker.name.toLowerCase().contains(query) ||
          speaker.role.toLowerCase().contains(query) ||
          speaker.topic.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  BxSpeakersControllerState copyWith({
    BxSpeakersStatus? status,
    List<BxSpeaker>? allSpeakers,
    int? selectedFilterIndex,
    String? searchQuery,
    String? errorMessage,
  }) {
    return BxSpeakersControllerState(
      status: status ?? this.status,
      allSpeakers: allSpeakers ?? this.allSpeakers,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allSpeakers,
    selectedFilterIndex,
    searchQuery,
    errorMessage,
  ];
}
