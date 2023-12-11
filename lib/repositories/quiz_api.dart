import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:master_quiz/models/quiz.dart';

class QuizApi {
  static const String baseUrl = 'https://quizzapi.jomoreschi.fr/api/v1/quiz';

  Future<List<Quiz>> getQuiz(String url) async {
    final http.Response response = await http.get(Uri.parse(baseUrl + url));
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      if (json.containsKey('results') && json['response_code'] == 0) {
        final List<String> results = json['results'];
        return results.map((String e) => Quiz.fromQuiApiJson(jsonDecode(e))).toList();
      } else {
        throw Exception('No results');
      }
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}