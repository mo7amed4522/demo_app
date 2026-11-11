// File: lib/presentation/bloc/bx_resources_controller/bx_resources_controller_state.dart
// Architecture: Presentation Layer - Resources Controller
// Purpose: State for resources controller BLoC

part of 'bx_resources_controller_bloc.dart';

enum BxResourcesStatus { initial, loading, success, error }

class BxResourceItem extends Equatable {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String tag;
  final Color tagColor;
  final String title;
  final String subtitle;
  final String size;
  final bool isDownloaded;
  final bool isSaved;

  const BxResourceItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.subtitle,
    required this.size,
    required this.isDownloaded,
    required this.isSaved,
  });

  BxResourceItem copyWith({bool? isDownloaded, bool? isSaved}) {
    return BxResourceItem(
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
      tag: tag,
      tagColor: tagColor,
      title: title,
      subtitle: subtitle,
      size: size,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
    icon,
    iconBgColor,
    iconColor,
    tag,
    tagColor,
    title,
    subtitle,
    size,
    isDownloaded,
    isSaved,
  ];
}

class BxResourcesControllerState extends Equatable {
  static const List<String> filters = [
    'All',
    'PDF',
    'Slides',
    'Videos',
    'Saved',
  ];

  static const List<BxResourceItem> defaultResources = [
    BxResourceItem(
      icon: Icons.picture_as_pdf,
      iconBgColor: Color(0xFFFCE4E4),
      iconColor: Color(0xFFE57373),
      tag: 'PDF',
      tagColor: Color(0xFFE57373),
      title: 'Congress Scientific Program',
      subtitle: 'Complete schedule and session details',
      size: '4.2 MB',
      isDownloaded: true,
      isSaved: false,
    ),
    BxResourceItem(
      icon: Icons.menu_book,
      iconBgColor: Color(0xFFE3F2FD),
      iconColor: Color(0xFF64B5F6),
      tag: 'PDF',
      tagColor: Color(0xFF64B5F6),
      title: 'Pediatric Nutrition Guide',
      subtitle: 'Clinical reference material',
      size: '2.8 MB',
      isDownloaded: false,
      isSaved: false,
    ),
    BxResourceItem(
      icon: Icons.co_present,
      iconBgColor: Color(0xFFFFF8E1),
      iconColor: Color(0xFFFFCA28),
      tag: 'SLIDES',
      tagColor: Color(0xFFFFCA28),
      title: 'Keynote Presentation Slides',
      subtitle: 'The Next Era of Nutrition & Health',
      size: '8.6 MB',
      isDownloaded: false,
      isSaved: false,
    ),
  ];

  final BxResourcesStatus status;
  final List<BxResourceItem> allResources;
  final int selectedFilterIndex;
  final String searchQuery;
  final String? errorMessage;

  const BxResourcesControllerState({
    this.status = BxResourcesStatus.initial,
    this.allResources = defaultResources,
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
    this.errorMessage,
  });

  List<BxResourceItem> get visibleResources {
    final filter = filters[selectedFilterIndex];
    final query = searchQuery.trim().toLowerCase();

    return allResources.where((item) {
      final matchesFilter = switch (filter) {
        'All' => true,
        'Saved' => item.isSaved,
        'Videos' => item.tag == 'VIDEO',
        _ => item.tag.toUpperCase() == filter.toUpperCase(),
      };

      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  BxResourcesControllerState copyWith({
    BxResourcesStatus? status,
    List<BxResourceItem>? allResources,
    int? selectedFilterIndex,
    String? searchQuery,
    String? errorMessage,
  }) {
    return BxResourcesControllerState(
      status: status ?? this.status,
      allResources: allResources ?? this.allResources,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allResources,
    selectedFilterIndex,
    searchQuery,
    errorMessage,
  ];
}
