// File: lib/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_state.dart
// Architecture: Presentation Layer - Ask Q&A Controller
// Purpose: State for ask Q&A controller BLoC

part of 'bx_ask_qa_controller_bloc.dart';

enum BxAskQaStatus { initial, loading, success, error }

class BxQaQuestion extends Equatable {
  final int upvotes;
  final String category;
  final String status;
  final String question;
  final String speaker;
  final String initials;

  const BxQaQuestion({
    required this.upvotes,
    required this.category,
    required this.status,
    required this.question,
    required this.speaker,
    required this.initials,
  });

  bool get isAnswered => status == 'Answered';

  BxQaQuestion copyWith({int? upvotes}) {
    return BxQaQuestion(
      upvotes: upvotes ?? this.upvotes,
      category: category,
      status: status,
      question: question,
      speaker: speaker,
      initials: initials,
    );
  }

  @override
  List<Object?> get props => [
    upvotes,
    category,
    status,
    question,
    speaker,
    initials,
  ];
}

class BxAskQaControllerState extends Equatable {
  static const List<String> categories = [
    'General',
    'Nutrition',
    'Research',
    'Clinical',
  ];

  static const List<String> sorts = ['Popular', 'Recent', 'Answered'];

  static const List<BxQaQuestion> defaultQuestions = [
    BxQaQuestion(
      upvotes: 24,
      category: 'Nutrition',
      status: 'Answered',
      question: 'How can pediatric nutrition plans be personalized for children with different growth patterns?',
      speaker: 'Dr. Ahmed',
      initials: 'D',
    ),
    BxQaQuestion(
      upvotes: 12,
      category: 'General',
      status: 'Open',
      question: 'What are the latest guidelines for early allergen introduction in infants?',
      speaker: 'Dr. Sarah',
      initials: 'S',
    ),
  ];

  final BxAskQaStatus status;
  final List<BxQaQuestion> allQuestions;
  final int selectedCategoryIndex;
  final int selectedSortIndex;
  final String? errorMessage;

  const BxAskQaControllerState({
    this.status = BxAskQaStatus.initial,
    this.allQuestions = defaultQuestions,
    this.selectedCategoryIndex = 0,
    this.selectedSortIndex = 1,
    this.errorMessage,
  });

  List<BxQaQuestion> get visibleQuestions {
    final list = List<BxQaQuestion>.from(allQuestions);
    switch (selectedSortIndex) {
      case 0:
        list.sort((a, b) => b.upvotes.compareTo(a.upvotes));
        break;
      case 2:
        return list.where((q) => q.isAnswered).toList();
      case 1:
      default:
        break;
    }
    return list;
  }

  BxAskQaControllerState copyWith({
    BxAskQaStatus? status,
    List<BxQaQuestion>? allQuestions,
    int? selectedCategoryIndex,
    int? selectedSortIndex,
    String? errorMessage,
  }) {
    return BxAskQaControllerState(
      status: status ?? this.status,
      allQuestions: allQuestions ?? this.allQuestions,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedSortIndex: selectedSortIndex ?? this.selectedSortIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allQuestions,
    selectedCategoryIndex,
    selectedSortIndex,
    errorMessage,
  ];
}
