import 'package:brewly/domain/entities/quiz_entity.dart';
import 'package:flutter/material.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState {}

final class QuizInProgress extends QuizState {
  final int currentQuestion;
  final Map<String, String> answers;

  QuizInProgress({required this.currentQuestion, required this.answers});
}

final class QuizCompleted extends QuizState {
  final QuizAnswer result;
  QuizCompleted(this.result);
}

final class QuizHistoryLoaded extends QuizState {
  final QuizHistory history;
  QuizHistoryLoaded(this.history);
}

final class QuizError extends QuizState {
  final String message;
  QuizError(this.message);
}
