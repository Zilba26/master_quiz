import 'package:master_quiz/models/difficulty.dart';

import 'category.dart';

class Quiz {
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
  Category category;
  Difficulty difficulty;

  Quiz({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
    required this.difficulty,
  });

  factory Quiz.fromQuiApiJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'] as String,
      correctAnswer: json['answer'] as String,
      incorrectAnswers: (json['bad_answers'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      category: Category.values.firstWhere((Category element) => element.key == json['category'] as String),
      difficulty: Difficulty.values.firstWhere((Difficulty element) => element.key == json['difficulty'] as String),
    );
  }

}