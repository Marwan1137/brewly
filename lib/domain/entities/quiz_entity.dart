class QuizAnswer {
  final String roastPreference; // 'Light', 'Medium', 'Dark'
  final String flavorProfile; // 'Floral', 'Fruity', 'Chocolate', 'Nutty'
  final String intensity; // 'Mild', 'Medium', 'Strong'
  final String brewingMethod; // 'Pour-over', 'Espresso', 'French Press'
  final DateTime completedAt;

  QuizAnswer({
    required this.roastPreference,
    required this.flavorProfile,
    required this.intensity,
    required this.brewingMethod,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() => {
    'roastPreference': roastPreference,
    'flavorProfile': flavorProfile,
    'intensity': intensity,
    'brewingMethod': brewingMethod,
    'completedAt': completedAt.toIso8601String(),
  };

  factory QuizAnswer.fromJson(Map<String, dynamic> json) => QuizAnswer(
    roastPreference: json['roastPreference'],
    flavorProfile: json['flavorProfile'],
    intensity: json['intensity'],
    brewingMethod: json['brewingMethod'],
    completedAt: DateTime.parse(json['completedAt']),
  );
}

class QuizHistory {
  final List<QuizAnswer> answers;

  QuizHistory(this.answers);

  QuizAnswer? get latestAnswer => answers.isEmpty ? null : answers.last;

  int get timesCompleted => answers.length;
}
