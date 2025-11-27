import 'dart:convert';
import 'package:brewly/domain/entities/quiz_entity.dart';
import 'package:brewly/domain/repositories/quiz_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: QuizRepo)
class QuizRepoImpl implements QuizRepo {
  final SharedPreferences _prefs;
  final SupabaseClient _supabase;

  QuizRepoImpl(this._prefs, this._supabase);

  String get _quizKey {
    final userId = _supabase.auth.currentUser?.id ?? 'guest';
    return 'quiz_history_$userId';
  }

  @override
  Future<void> saveQuizAnswer(QuizAnswer answer) async {
    final history = await getQuizHistory();
    history.answers.add(answer);

    final jsonList = history.answers.map((a) => a.toJson()).toList();
    await _prefs.setString(_quizKey, json.encode(jsonList));
  }

  @override
  Future<QuizHistory> getQuizHistory() async {
    final String? historyJson = _prefs.getString(_quizKey);
    if (historyJson == null) return QuizHistory([]);

    final List<dynamic> jsonList = json.decode(historyJson);
    final answers = jsonList.map((j) => QuizAnswer.fromJson(j)).toList();
    return QuizHistory(answers);
  }

  @override
  Future<bool> hasCompletedQuiz() async {
    final history = await getQuizHistory();
    return history.answers.isNotEmpty;
  }
}
