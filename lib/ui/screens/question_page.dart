import 'package:flutter/material.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/models/quiz.dart';
import 'package:master_quiz/repositories/quiz_api.dart';
import 'package:master_quiz/ui/components/main_button.dart';
import 'package:master_quiz/ui/components/record_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../constantes.dart';
import '../../models/category.dart';
import '../components/not_enough_questions.dart';

class QuestionPage extends StatefulWidget {

  final Category category;
  final Difficulty difficulty;

  const QuestionPage({super.key, required this.category, required this.difficulty});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  late List<Quiz> quiz;
  int _selectedIndex = 0;
  int _maxIndex = 10;
  bool _canNext = false;
  bool isLoading = true;
  final StopWatchTimer _stopwatch = StopWatchTimer();

  late List<String?> answersGuess;
  final List<int> timesAnswers = [];

  @override
  void initState() {
    loadQuiz();
    super.initState();
  }

  @override
  void dispose() {
    _stopwatch.dispose();
    super.dispose();
  }

  void resetGame() async {
    _stopwatch.onResetTimer();
    _selectedIndex = 0;
    await loadQuiz();
    timesAnswers.clear();
    _canNext = false;
    setState(() {});
  }

  Future<void> loadQuiz() async {
    QuizApi quizApi = QuizApi();
    quiz = await quizApi.getQuizByCategoryAndDifficulty(widget.category, widget.difficulty, _maxIndex);
    if (quiz.length < _maxIndex) _maxIndex = quiz.length;
    answersGuess = List.generate(_maxIndex, (index) => null);
    _stopwatch.onStartTimer();
    setState(() {
      isLoading = false;
    });
  }

  Color _getBorderAnswerBorderColor(String answer) {
    if (_canNext) {
      if (answer == quiz[_selectedIndex].correctAnswer) {
        return Colors.green;
      }
      if (answer == answersGuess[_selectedIndex]) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }

  int getScore() {
    int scoreTotal = 0;

    for (int i = 0; i < _maxIndex; i++) {
      if (answersGuess[i] == quiz[i].correctAnswer) {
        // Si la réponse est correcte
        int temps = timesAnswers[i];

        if (temps <= 5000) {
          // Meilleure note si la réponse est inférieure ou égale à 5s
          scoreTotal += 100;
        } else if (temps <= 30) {
          // Calculer le score entre 5s et 30s
          double pourcentage = 100 - ((temps - 5) / 25) * 100;
          scoreTotal += pourcentage < 0 ? 0 : pourcentage.round();
        } else {
          // Réponse trop lente, pas de points
          scoreTotal += 0;
        }
      } else {
        // Mauvaise réponse, pas de points
        scoreTotal += 0;
      }
    }

    return scoreTotal;
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    return Scaffold(
      body: Container(
        color: backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: isLoading ? const Center(child: CircularProgressIndicator())
            : (_maxIndex == 0 ? const NotEnoughQuestions() : Padding(
          padding: const EdgeInsets.symmetric( horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: appBar.preferredSize.height),
              StreamBuilder(
                stream: _stopwatch.rawTime,
                builder: (context, snap) {
                  final value = snap.data;
                  if (value == null) return const Text("");
                  Color color;
                  if (value < 20000) {
                    color = Colors.white;
                  } else if (value < 30000) {
                    color = Colors.orange;
                  } else {
                    color = Colors.red;
                  }
                  final displayTime = StopWatchTimer.getDisplayTime(value, hours: false);
                  return Text(displayTime, style: TextStyle(color: color, fontSize: 30));
                }
              ),
              const SizedBox(height: 30,),
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
              Text(quiz[_selectedIndex].question, style: const TextStyle(color: Colors.white, fontSize: 25)),
              Column(
                children: quiz[_selectedIndex].allAnswers.map((answer) => GestureDetector(
                  onTap: () {
                    if (_canNext) return;
                    setState(() {
                      answersGuess[_selectedIndex] = answer;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _getBorderAnswerBorderColor(answer).withOpacity(0.5), width: 4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(answer, style: const TextStyle(color: Colors.white, fontSize: 20)),
                        Container(
                          margin: const EdgeInsets.only(right: 14),
                          width: 30,
                          height: 30,
                          decoration: answer == answersGuess[_selectedIndex]
                            ? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue
                            ) : BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 3)
                            ),
                          child: answersGuess[_selectedIndex] == answer
                            ? const Icon(Icons.check, color: Colors.white,)
                            : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                )).toList(),
              ),
              const Spacer(),
              MainButton(
                fontSize: 22,
                onPressed: () async {
                  if (answersGuess[_selectedIndex] == null) return;
                  if (_canNext) {
                    if (_selectedIndex < _maxIndex - 1) {
                      setState(() {
                        _selectedIndex++;
                        _stopwatch.onResetTimer();
                        _stopwatch.onStartTimer();
                        _canNext = false;
                      });
                    } else {
                      timesAnswers.add(_stopwatch.rawTime.value);
                      _stopwatch.onStopTimer();
                      bool result = await showDialog(
                        context: context,
                        builder: (context) {
                          return RecordDialog(score: getScore(), category: widget.category, difficulty: widget.difficulty);
                        }
                      );
                      if (result) {
                        resetGame();
                      }
                    }
                  } else {
                    setState(() {
                      _canNext = true;
                      timesAnswers.add(_stopwatch.rawTime.value);
                      _stopwatch.onStopTimer();
                    });
                  }
                },
                text: _canNext ? 'Next' : 'Valider',
              ),
              const SizedBox(height: 50,),
            ],
          ),
        )),
      )
    );
  }
}