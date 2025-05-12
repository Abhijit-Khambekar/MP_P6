import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/score_model.dart';

class ScoreboardTab extends StatefulWidget {
  const ScoreboardTab({super.key});

  @override
  State<ScoreboardTab> createState() => _ScoreboardTabState();
}

class _ScoreboardTabState extends State<ScoreboardTab> {
  List<ScoreModel> scores = [];

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  void loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoreStrings = prefs.getStringList('scores') ?? [];
    setState(() {
      scores = scoreStrings.map((s) => ScoreModel.fromString(s)).toList()
        ..sort((a, b) => b.score.compareTo(a.score));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[100],
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: scores.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.yellow[200],
            child: ListTile(
              title: Text('Score: ${scores[index].score}'),
              subtitle: Text('Date: ${scores[index].date.toString().substring(0, 10)}'),
            ),
          );
        },
      ),
    );
  }
}