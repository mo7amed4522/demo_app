// File: lib/presentation/bloc/bx_live_voting_controller/bx_live_voting_controller_state.dart
// Architecture: Presentation Layer - Live Voting Controller
// Purpose: State for live voting controller BLoC

part of 'bx_live_voting_controller_bloc.dart';

enum BxLiveVotingStatus { initial, loading, success, error }

class BxPollOption extends Equatable {
  final String title;
  final String percentage;
  final String votes;
  final Color progressColor;
  final double progressValue;
  final bool isSelected;

  const BxPollOption({
    required this.title,
    required this.percentage,
    required this.votes,
    required this.progressColor,
    required this.progressValue,
    required this.isSelected,
  });

  BxPollOption copyWith({bool? isSelected}) {
    return BxPollOption(
      title: title,
      percentage: percentage,
      votes: votes,
      progressColor: progressColor,
      progressValue: progressValue,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
    title,
    percentage,
    votes,
    progressColor,
    progressValue,
    isSelected,
  ];
}

/// A single poll (question + options + metadata).
class BxPoll extends Equatable {
  final String subtitle;
  final String badge; // e.g. 'VOTED'
  final String question;
  final String totalVotes;
  final List<BxPollOption> options;

  const BxPoll({
    required this.subtitle,
    required this.badge,
    required this.question,
    required this.totalVotes,
    required this.options,
  });

  BxPoll copyWith({List<BxPollOption>? options}) {
    return BxPoll(
      subtitle: subtitle,
      badge: badge,
      question: question,
      totalVotes: totalVotes,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [subtitle, badge, question, totalVotes, options];
}

class BxLiveVotingControllerState extends Equatable {
  final BxLiveVotingStatus status;
  final List<BxPoll> polls;
  final int activePollIndex;
  final String? errorMessage;

  const BxLiveVotingControllerState({
    this.status = BxLiveVotingStatus.initial,
    this.polls = defaultPolls,
    this.activePollIndex = 0,
    this.errorMessage,
  });

  static const List<BxPoll> defaultPolls = [
    BxPoll(
      subtitle: 'Audience Feedback',
      badge: 'VOTED',
      question: 'How would you rate the\ncurrent session?',
      totalVotes: '101 total votes',
      options: [
        BxPollOption(
          title: 'Excellent',
          percentage: '54%',
          votes: '55 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.54,
          isSelected: false,
        ),
        BxPollOption(
          title: 'Very Good',
          percentage: '31%',
          votes: '31 votes',
          progressColor: Color(0xFFFFD54F),
          progressValue: 0.31,
          isSelected: true,
        ),
        BxPollOption(
          title: 'Good',
          percentage: '10%',
          votes: '10 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.10,
          isSelected: false,
        ),
      ],
    ),

    BxPoll(
      subtitle: 'Audience Feedback',
      badge: 'VOTED',
      question: 'Which topic would you\nlike to explore more?',
      totalVotes: '87 total votes',
      options: [
        BxPollOption(
          title: 'Nutrition Science',
          percentage: '45%',
          votes: '39 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.45,
          isSelected: true,
        ),
        BxPollOption(
          title: 'Clinical Research',
          percentage: '32%',
          votes: '28 votes',
          progressColor: Color(0xFFFFD54F),
          progressValue: 0.32,
          isSelected: false,
        ),
        BxPollOption(
          title: 'Pediatric Care',
          percentage: '23%',
          votes: '20 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.23,
          isSelected: false,
        ),
      ],
    ),

    BxPoll(
      subtitle: 'Audience Feedback',
      badge: 'VOTED',
      question: 'How satisfied are you\nwith the event today?',
      totalVotes: '64 total votes',
      options: [
        BxPollOption(
          title: 'Very Satisfied',
          percentage: '62%',
          votes: '40 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.62,
          isSelected: false,
        ),
        BxPollOption(
          title: 'Satisfied',
          percentage: '28%',
          votes: '18 votes',
          progressColor: Color(0xFFFFD54F),
          progressValue: 0.28,
          isSelected: true,
        ),
        BxPollOption(
          title: 'Neutral',
          percentage: '10%',
          votes: '6 votes',
          progressColor: Color(0xFF00C6FF),
          progressValue: 0.10,
          isSelected: false,
        ),
      ],
    ),
  ];

  BxPoll get activePoll => polls[activePollIndex];

  int get pollCount => polls.length;

  bool get canGoPrevious => activePollIndex > 0;

  bool get canGoNext => activePollIndex < polls.length - 1;

  BxLiveVotingControllerState copyWith({
    BxLiveVotingStatus? status,
    List<BxPoll>? polls,
    int? activePollIndex,
    String? errorMessage,
  }) {
    return BxLiveVotingControllerState(
      status: status ?? this.status,
      polls: polls ?? this.polls,
      activePollIndex: activePollIndex ?? this.activePollIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, polls, activePollIndex, errorMessage];
}
