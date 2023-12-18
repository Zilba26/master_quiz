import 'package:flutter/material.dart';
import 'package:master_quiz/ui/screens/home.dart';
import 'package:master_quiz/ui/screens/choose_options.dart';
import 'package:master_quiz/ui/screens/question_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Quizz',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/question': (context) => const QuestionPage(),
        '/options': (context) => const ChooseOptions(),
      },
      initialRoute: '/home',
    );
  }
}