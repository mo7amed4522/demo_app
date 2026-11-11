// File: lib/presentation/bloc/bx_congress_agenda_controller/bx_congress_agenda_controller_state.dart
// Architecture: Presentation Layer - Congress Agenda Controller
// Purpose: State for congress agenda controller BLoC

part of 'bx_congress_agenda_controller_bloc.dart';

enum BxCongressAgendaStatus { initial, loading, success, error }

class BxAgendaSession extends Equatable {
  final String time;
  final String period;
  final String tag;
  final String title;
  final String speaker;
  final bool isBookmarked;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final int day;

  const BxAgendaSession({
    required this.time,
    required this.period,
    required this.tag,
    required this.title,
    required this.speaker,
    required this.isBookmarked,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.day,
  });

  BxAgendaSession copyWith({bool? isBookmarked}) {
    return BxAgendaSession(
      time: time,
      period: period,
      tag: tag,
      title: title,
      speaker: speaker,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
      day: day,
    );
  }

  @override
  List<Object?> get props => [
    time,
    period,
    tag,
    title,
    speaker,
    isBookmarked,
    icon,
    iconBgColor,
    iconColor,
    day,
  ];
}

class BxCongressAgendaControllerState extends Equatable {
  static const List<String> filters = [
    'All',
    'Keynote',
    'Nutrition',
    'Research',
  ];

  static const List<String> dayTitles = ['Day 1', 'Day 2'];
  static const List<String> dayDates = ['May 22', 'May 23'];
  static const List<String> dayFullDates = [
    'Thursday, May 22, 2026',
    'Friday, May 23, 2026',
  ];

  static const List<BxAgendaSession> defaultSessions = [
    // --- Day 1 ---
    BxAgendaSession(
      time: '08:30',
      period: 'AM',
      tag: 'KEYNOTE',
      title: 'Opening Ceremony',
      speaker: 'Main Auditorium',
      isBookmarked: false,
      icon: Icons.event_available,
      iconBgColor: Color(0xFFFFF3E0),
      iconColor: Colors.orange,
      day: 0,
    ),
    BxAgendaSession(
      time: '09:30',
      period: 'AM',
      tag: 'KEYNOTE',
      title: 'Welcome & Introduction',
      speaker: 'Dr. Hassan Ali',
      isBookmarked: false,
      icon: Icons.mic,
      iconBgColor: Color(0xFFE3F2FD),
      iconColor: Colors.blue,
      day: 0,
    ),
    BxAgendaSession(
      time: '10:30',
      period: 'AM',
      tag: 'NUTRITION',
      title: 'Future of Pediatric Nutrition',
      speaker: 'Dr. Sarah Johnson',
      isBookmarked: false,
      icon: Icons.spa,
      iconBgColor: Color(0xFFE0F7FA),
      iconColor: Colors.blue,
      day: 0,
    ),
    // --- Day 2 ---
    BxAgendaSession(
      time: '09:00',
      period: 'AM',
      tag: 'RESEARCH',
      title: 'Clinical Research Update',
      speaker: 'Dr. James Carter',
      isBookmarked: false,
      icon: Icons.science_outlined,
      iconBgColor: Color(0xFFEDE7F6),
      iconColor: Colors.deepPurple,
      day: 1,
    ),
    BxAgendaSession(
      time: '11:00',
      period: 'AM',
      tag: 'NUTRITION',
      title: 'Nutrition in Critical Care',
      speaker: 'Dr. Lisa Martin',
      isBookmarked: false,
      icon: Icons.spa,
      iconBgColor: Color(0xFFE0F7FA),
      iconColor: Colors.blue,
      day: 1,
    ),
  ];

  final BxCongressAgendaStatus status;
  final List<BxAgendaSession> allSessions;
  final int selectedDayIndex;
  final int selectedFilterIndex;
  final String? errorMessage;

  const BxCongressAgendaControllerState({
    this.status = BxCongressAgendaStatus.initial,
    this.allSessions = defaultSessions,
    this.selectedDayIndex = 0,
    this.selectedFilterIndex = 0,
    this.errorMessage,
  });

  List<BxAgendaSession> get visibleSessions {
    final filter = filters[selectedFilterIndex].toUpperCase();

    return allSessions.where((session) {
      if (session.day != selectedDayIndex) return false;
      if (filter == 'ALL') return true;
      return session.tag == filter;
    }).toList();
  }

  BxCongressAgendaControllerState copyWith({
    BxCongressAgendaStatus? status,
    List<BxAgendaSession>? allSessions,
    int? selectedDayIndex,
    int? selectedFilterIndex,
    String? errorMessage,
  }) {
    return BxCongressAgendaControllerState(
      status: status ?? this.status,
      allSessions: allSessions ?? this.allSessions,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allSessions,
    selectedDayIndex,
    selectedFilterIndex,
    errorMessage,
  ];
}
