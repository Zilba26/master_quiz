import 'package:master_quiz/models/difficulty.dart';

import 'category.dart';

class Quiz {
  String question;
  String correctAnswer;
  List<String> allAnswers;
  Category category;
  Difficulty difficulty;

  Quiz({
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
    required this.category,
    required this.difficulty,
  });

  factory Quiz.fromQuiApiJson(Map<String, dynamic> json) {
    final badAnswers = json["badAnswers"] as List<dynamic>;
    final allAnswers = [...badAnswers.map((e) => e.toString()), json["answer"].toString()];
    allAnswers.shuffle();
    return Quiz(
      question: json['question'] as String,
      correctAnswer: json['answer'] as String,
      allAnswers: allAnswers,
      category: Category.values.firstWhere((Category element) => element.key == json['category'] as String),
      difficulty: Difficulty.values.firstWhere((Difficulty element) => element.key == json['difficulty'] as String),
    );
  }

}