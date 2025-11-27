import 'package:brewly/Presentation/Screens/quiz/logic/quiz_state.dart';
import 'package:brewly/domain/entities/quiz_entity.dart';
import 'package:brewly/domain/repositories/quiz_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class QuizCubit extends Cubit<QuizState> {
  final QuizRepo _quizRepo;

  QuizCubit(this._quizRepo) : super(QuizInitial());

  Future<void> checkQuizStatus() async {
    try {
      emit(QuizLoading());
      final hasCompleted = await _quizRepo.hasCompletedQuiz();

      if (hasCompleted) {
        final history = await _quizRepo.getQuizHistory();
        emit(QuizHistoryLoaded(history));
      } else {
        startQuiz();
      }
    } catch (e) {
      emit(QuizError('Failed to load quiz: $e'));
    }
  }

  void startQuiz() {
    emit(QuizInProgress(currentQuestion: 0, answers: {}));
  }

  void answerQuestion(String questionKey, String answer) {
    if (state is QuizInProgress) {
      final current = state as QuizInProgress;
      final newAnswers = Map<String, String>.from(current.answers);
      newAnswers[questionKey] = answer;

      if (current.currentQuestion < 3) {
        // More questions to go
        emit(
          QuizInProgress(
            currentQuestion: current.currentQuestion + 1,
            answers: newAnswers,
          ),
        );
      } else {
        // Quiz completed
        _completeQuiz(newAnswers);
      }
    }
  }

  Future<void> _completeQuiz(Map<String, String> answers) async {
    try {
      final quizAnswer = QuizAnswer(
        roastPreference: answers['roast'] ?? 'Medium',
        flavorProfile: answers['flavor'] ?? 'Balanced',
        intensity: answers['intensity'] ?? 'Medium',
        brewingMethod: answers['brewing'] ?? 'Drip',
        completedAt: DateTime.now(),
      );

      await _quizRepo.saveQuizAnswer(quizAnswer);
      emit(QuizCompleted(quizAnswer));
    } catch (e) {
      emit(QuizError('Failed to save quiz: $e'));
    }
  }

  Future<void> loadHistory() async {
    try {
      emit(QuizLoading());
      final history = await _quizRepo.getQuizHistory();
      emit(QuizHistoryLoaded(history));
    } catch (e) {
      emit(QuizError('Failed to load history: $e'));
    }
  }

  void retakeQuiz() {
    startQuiz();
  }
}
