import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/models/quiz.dart';
import 'package:master_quiz/models/category.dart';

class QuizApi {
  static const String baseUrl = 'https://quizzapi.jomoreschi.fr/api/v1/quiz';

  Future<List<Quiz>> getQuiz(String url) async {
    final http.Response response = await http.get(Uri.parse(baseUrl + url));
    if (response.statusCode == 200) {
      final List<Quiz> quizzes = [];
      final dynamic json = jsonDecode(response.body);
      if (json.containsKey('quizzes')) {
        final List<dynamic> results = json['quizzes'];
        for (Map<String, dynamic> result in results) {
          final Quiz quiz = Quiz.fromQuiApiJson(result);
          quizzes.add(quiz);
        }
        return quizzes;
      } else {
        throw Exception('No results');
      }
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  Future<List<Quiz>> getQuizByCategory(Category category, [int? limit]) async {
    return await getQuiz('?category=${category.key}${limit == null ? '' : '&limit=$limit'}');
  }

  Future<List<Quiz>> getQuizByDifficulty(Difficulty difficulty, [int? limit]) async {
    return await getQuiz('?difficulty=${difficulty.key}${limit == null ? '' : '&limit=$limit'}');
  }

  Future<List<Quiz>> getQuizByCategoryAndDifficulty(Category category, Difficulty difficulty, [int? limit]) async {
    return await getQuiz('?category=${category.key}&difficulty=${difficulty.key}${limit == null ? '' : '&limit=$limit'}');
  }

  Future<List<String>> getCategories() async {
    final http.Response response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final List<String> categories = [];
      final dynamic json = jsonDecode(response.body);
      if (json.containsKey('categories')) {
        final List<dynamic> results = json['categories'];
        for (String result in results) {
          categories.add(result);
        }
        return categories;
      } else {
        throw Exception('No results');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<String>> getDifficulties() async {
    final http.Response response = await http.get(Uri.parse('$baseUrl/difficulties'));
    if (response.statusCode == 200) {
      final List<String> difficulties = [];
      final dynamic json = jsonDecode(response.body);
      if (json.containsKey('difficulties')) {
        final List<dynamic> results = json['difficulties'];
        for (String result in results) {
          difficulties.add(result);
        }
        return difficulties;
      } else {
        throw Exception('No results');
      }
    } else {
      throw Exception('Failed to load difficulties');
    }
  }
}