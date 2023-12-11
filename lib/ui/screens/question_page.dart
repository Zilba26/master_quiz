import 'package:flutter/material.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/models/quiz.dart';
import 'package:master_quiz/repositories/quiz_api.dart';

import '../../models/category.dart';

class QuestionPage extends StatefulWidget {

  final Category category;
  final Difficulty difficulty;

  const QuestionPage({super.key, required this.category, required this.difficulty});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  List<Quiz>? quiz;
  int _selectedIndex = 0;
  int _maxIndex = 10;

  String? answerGuess;

  @override
  void initState() {
    loadQuiz();
    super.initState();
  }

  Future<void> loadQuiz() async {
    QuizApi quizApi = QuizApi();
    quiz = await quizApi.getQuizByCategoryAndDifficulty(widget.category, widget.difficulty, _maxIndex);
    if (quiz!.length < _maxIndex) _maxIndex = quiz!.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: quiz == null ? const Center(child: CircularProgressIndicator()) : Container(
        color: const Color.fromRGBO(32, 40, 73, 1),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Question ${_selectedIndex + 1}', style: const TextStyle(color: Colors.grey, fontSize: 25)),
                        TextSpan(text: "/ $_maxIndex", style: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 18)),
                      ]
                    )
                  ),
                ],
              ),
              const Divider(height: 50,),
              Text(quiz![_selectedIndex].question, style: const TextStyle(color: Colors.white, fontSize: 25)),
              Column(
                children: quiz![_selectedIndex].allAnswers.map((answer) => GestureDetector(
                  onTap: () {
                    setState(() {
                      answerGuess = answer;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(answer, style: const TextStyle(color: Colors.white, fontSize: 20)),
                        Container(
                          margin: const EdgeInsets.only(right: 14),
                          width: 30,
                          height: 30,
                          decoration: answer == answerGuess
                            ? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue
                            ) : BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 3)
                            ),
                          child: answerGuess == answer
                            ? const Icon(Icons.check, color: Colors.white,)
                            : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                )).toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_selectedIndex < _maxIndex - 1) {
                    setState(() {
                      _selectedIndex++;
                      answerGuess = null;
                    });
                  } else {
                    //TODO: Go to result page
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))))
                ),
                child: const Text('Next', style: TextStyle(fontSize: 22, color: Colors.white))
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      )
    );
  }
}
