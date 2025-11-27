import 'package:brewly/domain/entities/quiz_entity.dart';

abstract class QuizRepo {
  Future<void> saveQuizAnswer(QuizAnswer answer);
  Future<QuizHistory> getQuizHistory();
  Future<bool> hasCompletedQuiz();
}
