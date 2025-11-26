// ignore_for_file: deprecated_member_use

import 'package:brewly/Presentation/Screens/explore_tab/explore_screen.dart';
import 'package:brewly/Presentation/Screens/quiz/logic/quiz_cubit.dart';
import 'package:brewly/Presentation/Screens/quiz/logic/quiz_state.dart';
import 'package:brewly/data/DI/di.dart';
import 'package:brewly/domain/entities/quiz_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizCubit>()..checkQuizStatus(),
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          elevation: 0,
          title: const Text(
            'Coffee Taste Quiz',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is QuizInProgress) {
              return _QuizQuestions(
                currentQuestion: state.currentQuestion,
                onAnswer: (key, answer) {
                  context.read<QuizCubit>().answerQuestion(key, answer);
                },
              );
            }

            if (state is QuizCompleted) {
              return _QuizResults(result: state.result);
            }

            if (state is QuizHistoryLoaded) {
              return _QuizHistory(history: state.history);
            }

            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<QuizCubit>().startQuiz(),
                child: const Text('Start Quiz'),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Quiz Questions Widget
class _QuizQuestions extends StatelessWidget {
  final int currentQuestion;
  final Function(String, String) onAnswer;

  const _QuizQuestions({required this.currentQuestion, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    final questions = [
      {
        'key': 'roast',
        'question': 'What roast level do you prefer?',
        'options': ['Light', 'Medium', 'Dark'],
        'icons': [Icons.wb_sunny, Icons.cloud, Icons.nightlight_round],
      },
      {
        'key': 'flavor',
        'question': 'What flavor profile do you enjoy?',
        'options': [
          'Floral & Citrus',
          'Fruity & Berry',
          'Chocolate & Nutty',
          'Earthy & Spicy',
        ],
        'icons': [
          Icons.local_florist,
          Icons.apple,
          Icons.cookie,
          Icons.terrain,
        ],
      },
      {
        'key': 'intensity',
        'question': 'How strong do you like your coffee?',
        'options': ['Mild', 'Medium', 'Strong', 'Very Strong'],
        'icons': [Icons.opacity, Icons.water_drop, Icons.bolt, Icons.flash_on],
      },
      {
        'key': 'brewing',
        'question': 'What\'s your preferred brewing method?',
        'options': ['Pour-over', 'Espresso', 'French Press', 'Drip Coffee'],
        'icons': [
          Icons.filter_vintage,
          Icons.local_cafe,
          Icons.coffee,
          Icons.coffee_maker,
        ],
      },
    ];

    final currentQ = questions[currentQuestion];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation(
                Color.fromARGB(255, 156, 88, 6),
              ),
            ),
            const SizedBox(height: 20),

            // Question Number
            Text(
              'Question ${currentQuestion + 1} of ${questions.length}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),

            // Question Text
            Text(
              currentQ['question'] as String,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 40),

            // Answer Options
            ...List.generate((currentQ['options'] as List<String>).length, (
              index,
            ) {
              final option = (currentQ['options'] as List<String>)[index];
              final icon = (currentQ['icons'] as List<IconData>)[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _OptionCard(
                  text: option,
                  icon: icon,
                  onTap: () {
                    onAnswer(currentQ['key'] as String, option);
                  },
                ).animate().fadeIn(delay: (100 * index).ms),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Option Card Widget
class _OptionCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _OptionCard({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 156, 88, 6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 156, 88, 6),
                size: 28,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}

// Quiz Results Widget
class _QuizResults extends StatelessWidget {
  final QuizAnswer result;

  const _QuizResults({required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.celebration,
              size: 80,
              color: Color.fromARGB(255, 156, 88, 6),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Here\'s your coffee profile',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            _ResultCard(
              icon: Icons.wb_sunny,
              title: 'Roast Preference',
              value: result.roastPreference,
            ),
            const SizedBox(height: 15),

            _ResultCard(
              icon: Icons.local_florist,
              title: 'Flavor Profile',
              value: result.flavorProfile,
            ),
            const SizedBox(height: 15),

            _ResultCard(
              icon: Icons.bolt,
              title: 'Intensity',
              value: result.intensity,
            ),
            const SizedBox(height: 15),

            _ResultCard(
              icon: Icons.coffee,
              title: 'Brewing Method',
              value: result.brewingMethod,
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 156, 88, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExploreScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Explore Your Matches',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ResultCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 156, 88, 6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 156, 88, 6),
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Quiz History Widget
class _QuizHistory extends StatelessWidget {
  final QuizHistory history;

  const _QuizHistory({required this.history});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Coffee Profile',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'You\'ve completed the quiz ${history.timesCompleted} time${history.timesCompleted > 1 ? 's' : ''}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            if (history.latestAnswer != null) ...[
              const Text(
                'Current Preferences',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              _ResultCard(
                icon: Icons.wb_sunny,
                title: 'Roast Preference',
                value: history.latestAnswer!.roastPreference,
              ),
              const SizedBox(height: 15),

              _ResultCard(
                icon: Icons.local_florist,
                title: 'Flavor Profile',
                value: history.latestAnswer!.flavorProfile,
              ),
              const SizedBox(height: 15),

              _ResultCard(
                icon: Icons.bolt,
                title: 'Intensity',
                value: history.latestAnswer!.intensity,
              ),
              const SizedBox(height: 15),

              _ResultCard(
                icon: Icons.coffee,
                title: 'Brewing Method',
                value: history.latestAnswer!.brewingMethod,
              ),
            ],

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 156, 88, 6),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  context.read<QuizCubit>().retakeQuiz();
                },
                child: const Text(
                  'Retake Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 156, 88, 6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Quiz History Timeline
            if (history.answers.length > 1) ...[
              const Text(
                'Quiz History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              ...history.answers.reversed.map((answer) {
                return _HistoryItem(answer: answer);
              }),
            ],
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final QuizAnswer answer;

  const _HistoryItem({required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: Color.fromARGB(255, 156, 88, 6)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${answer.roastPreference} • ${answer.flavorProfile}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(answer.completedAt),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
