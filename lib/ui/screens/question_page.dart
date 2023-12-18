import 'package:flutter/material.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/models/quiz.dart';
import 'package:master_quiz/repositories/quiz_api.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
    setState(() {});
  }

  Future<void> loadQuiz() async {
    QuizApi quizApi = QuizApi();
    quiz = await quizApi.getQuizByCategoryAndDifficulty(widget.category, widget.difficulty, _maxIndex);
    if (quiz!.length < _maxIndex) _maxIndex = quiz!.length;
    answersGuess = List.generate(_maxIndex, (index) => null);
    _stopwatch.onStartTimer();
    setState(() {});
  }

  int getScore() {
    int score = 0;
    for (int i = 0; i < _maxIndex; i++) {
      if (quiz![i].correctAnswer == answersGuess[i]) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    return Scaffold(
      body: quiz == null ? const Center(child: CircularProgressIndicator()) : Container(
        color: const Color.fromRGBO(32, 40, 73, 1),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
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
              Text(quiz![_selectedIndex].question, style: const TextStyle(color: Colors.white, fontSize: 25)),
              Column(
                children: quiz![_selectedIndex].allAnswers.map((answer) => GestureDetector(
                  onTap: () {
                    setState(() {
                      answersGuess[_selectedIndex] = answer;
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
              ElevatedButton(
                onPressed: () {
                  if (answersGuess[_selectedIndex] == null) return;
                  if (_selectedIndex < _maxIndex - 1) {
                    setState(() {
                      _selectedIndex++;
                      timesAnswers.add(_stopwatch.rawTime.value);
                      _stopwatch.onResetTimer();
                      _stopwatch.onStartTimer();
                    });
                  } else {
                    timesAnswers.add(_stopwatch.rawTime.value);
                    _stopwatch.onStopTimer();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Quiz terminé'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Score: ${getScore()}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 20,),
                              const Text("Vous avez battu votre record", style: TextStyle(fontSize: 16),),
                              const SizedBox(height: 10,),
                              const Text("Record: TODO", style: TextStyle(fontSize: 16),)
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                //Navigator.pop(context);
                              },
                              child: const Text('Accueil')
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                resetGame();
                              },
                              child: const Text('Rejouer')
                            )
                          ],
                        );
                      }
                    );
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
