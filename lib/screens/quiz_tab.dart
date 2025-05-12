import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/score_model.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  int score = 0;
  int currentQuestion = 0;
  
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What comes after A?',
      'options': ['B', 'C', 'D'],
      'correct': 'B'
    },
    {
      'question': 'What is 2 + 3?',
      'options': ['4', '5', '6'],
      'correct': '5'
    },
    {
      'question': 'Which letter comes before C?',
      'options': ['A', 'B', 'D'],
      'correct': 'B'
    },
    {
      'question': 'What is 5 - 2?',
      'options': ['3', '2', '4'],
      'correct': '3'
    },
    {
      'question': 'What comes after 9?',
      'options': ['8', '10', '11'],
      'correct': '10'
    },
  ];

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == questions[currentQuestion]['correct']) {
      score += 10;
    }
    setState(() {
      currentQuestion++;
    });
  }

  void saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scores = prefs.getStringList('scores') ?? [];
    scores.add(ScoreModel(score: score, date: DateTime.now()).toString());
    await prefs.setStringList('scores', scores);
    setState(() {
      score = 0;
      currentQuestion = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (currentQuestion < questions.length)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    questions[currentQuestion]['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[200],
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () => checkAnswer(
                          questions[currentQuestion]['options'][index]),
                      child: Text(
                        questions[currentQuestion]['options'][index],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            )
          else
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Quiz Completed! Score: $score',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: saveScore,
                  child: const Text(
                    'Save Score',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}