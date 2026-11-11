// File: lib/presentation/bloc/bx_ask_qa_controller/bx_ask_qa_controller_event.dart
// Architecture: Presentation Layer - Ask Q&A Controller
// Purpose: Events for ask Q&A controller BLoC

part of 'bx_ask_qa_controller_bloc.dart';

abstract class BxAskQaControllerEvent extends Equatable {
  const BxAskQaControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxAskQaLoadRequested extends BxAskQaControllerEvent {}

class BxAskQaCategoryChanged extends BxAskQaControllerEvent {
  final int categoryIndex;

  const BxAskQaCategoryChanged(this.categoryIndex);

  @override
  List<Object?> get props => [categoryIndex];
}

class BxAskQaSortChanged extends BxAskQaControllerEvent {
  final int sortIndex;

  const BxAskQaSortChanged(this.sortIndex);

  @override
  List<Object?> get props => [sortIndex];
}

class BxAskQaSubmitted extends BxAskQaControllerEvent {}

class BxAskQaUpvoted extends BxAskQaControllerEvent {
  final int questionIndex;

  const BxAskQaUpvoted(this.questionIndex);

  @override
  List<Object?> get props => [questionIndex];
}
