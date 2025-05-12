class ScoreModel {
  final int score;
  final DateTime date;

  ScoreModel({required this.score, required this.date});

  factory ScoreModel.fromString(String str) {
    final parts = str.split('|');
    return ScoreModel(
      score: int.parse(parts[0]),
      date: DateTime.parse(parts[1]),
    );
  }

  @override
  String toString() => '$score|${date.toIso8601String()}';
}