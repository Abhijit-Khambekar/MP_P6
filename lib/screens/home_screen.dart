import 'package:flutter/material.dart';
import 'lessons_tab.dart';
import 'quiz_tab.dart';
import 'scoreboard_tab.dart';
import 'profile_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: const Text('Kids Learning App'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Lessons'),
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
              Tab(icon: Icon(Icons.score), text: 'Scoreboard'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LessonsTab(),
            QuizTab(),
            ScoreboardTab(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}