// File: lib/presentation/bloc/bx_quick_access_controller/bx_quick_access_controller_state.dart
// Architecture: Presentation Layer - Quick Access Controller
// Purpose: State for quick access controller BLoC

part of 'bx_quick_access_controller_bloc.dart';

/// Lifecycle status for the quick access screen.
enum BxQuickAccessStatus { initial, loading, success, error }

class BxQuickAccessItem extends Equatable {
  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;

  const BxQuickAccessItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  @override
  List<Object?> get props => [icon, title, subtitle, tag];
}

class BxQuickAccessControllerState extends Equatable {
  static const List<String> filters = ['All', 'Event', 'Interactive', 'Tools'];

  static const List<BxQuickAccessItem> defaultItems = [
    BxQuickAccessItem(
      icon: Icons.calendar_today_outlined,
      title: 'Agenda',
      subtitle: 'View full congress schedule',
      tag: 'Event',
    ),
    BxQuickAccessItem(
      icon: Icons.people_outline,
      title: 'Speakers',
      subtitle: 'Explore global medical experts',
      tag: 'Event',
    ),
    BxQuickAccessItem(
      icon: Icons.badge_outlined,
      title: 'Name Tag',
      subtitle: 'Access your digital badge',
      tag: 'Event',
    ),
    BxQuickAccessItem(
      icon: Icons.location_on_outlined,
      title: 'Venue',
      subtitle: 'Location, facilities and directions',
      tag: 'Event',
    ),
    BxQuickAccessItem(
      icon: Icons.poll_outlined,
      title: 'Voting',
      subtitle: 'Participate in live polls',
      tag: 'Interactive',
    ),
    BxQuickAccessItem(
      icon: Icons.help_outline,
      title: 'Ask Q&A',
      subtitle: 'Submit questions to speakers',
      tag: 'Interactive',
    ),
    BxQuickAccessItem(
      icon: Icons.folder_outlined,
      title: 'Resources',
      subtitle: 'Access session materials',
      tag: 'Tools',
    ),
    BxQuickAccessItem(
      icon: Icons.storefront_outlined,
      title: 'Exhibitors',
      subtitle: 'Explore partner booths',
      tag: 'Event',
    ),
  ];

  final BxQuickAccessStatus status;

  /// Master list — seeded with [defaultItems] on the very first frame so
  /// the UI can display content immediately instead of showing "No items".
  final List<BxQuickAccessItem> allItems;
  final int selectedFilterIndex;
  final String searchQuery;
  final String? errorMessage;

  const BxQuickAccessControllerState({
    this.status = BxQuickAccessStatus.initial,
    this.allItems = defaultItems, // ← seeded with defaults
    this.selectedFilterIndex = 0,
    this.searchQuery = '',
    this.errorMessage,
  });

  List<BxQuickAccessItem> get visibleItems {
    final filter = filters[selectedFilterIndex];
    final query = searchQuery.trim().toLowerCase();

    return allItems.where((item) {
      final matchesFilter = filter == 'All' || item.tag == filter;
      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  BxQuickAccessControllerState copyWith({
    BxQuickAccessStatus? status,
    List<BxQuickAccessItem>? allItems,
    int? selectedFilterIndex,
    String? searchQuery,
    String? errorMessage,
  }) {
    return BxQuickAccessControllerState(
      status: status ?? this.status,
      allItems: allItems ?? this.allItems,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allItems,
    selectedFilterIndex,
    searchQuery,
    errorMessage,
  ];
}
