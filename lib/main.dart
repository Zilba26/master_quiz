import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_quiz/blocs/record_cubit.dart';
import 'package:master_quiz/ui/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final RecordCubit recordCubit = RecordCubit();
  recordCubit.loadRecords();
  runApp(BlocProvider<RecordCubit>(
      create: (_) => recordCubit,
      child: const MyApp())
  );
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}