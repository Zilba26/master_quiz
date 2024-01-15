import 'package:flutter/material.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/ui/components/main_button.dart';
import 'package:master_quiz/models/category.dart';
import 'package:master_quiz/ui/components/main_dropdown_button.dart';
import 'package:master_quiz/ui/components/star_background.dart';
import 'package:master_quiz/ui/screens/question_page.dart';

import '../../constantes.dart';

class ChooseOptions extends StatefulWidget {
  const ChooseOptions({Key? key}) : super(key: key);

  @override
  State<ChooseOptions> createState() => _ChooseOptionsState();
}

class _ChooseOptionsState extends State<ChooseOptions> {
  List<Category> categories = Category.values;
  List<Difficulty> difficulties = Difficulty.values;

  Category selectedCategory = Category.all;
  Difficulty selectedDifficulty = Difficulty.easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: StarBackground(
          animated: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    const Text(
                      'Sélectionnez la catégorie',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 30.0),
                    MainDropdownButton(values: categories, onChange: (value) => selectedCategory = value!)
                  ],
                ),
                const SizedBox(height: 75),
                Column(
                  children: [
                    const Text(
                      'Sélectionnez la difficulté',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    MainDropdownButton(values: difficulties, onChange: (value) => selectedDifficulty = value!),
                  ],
                ),
                const SizedBox(height: 100),
                MainButton(
                  text: 'Jouer',
                  fontSize: 30.0,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuestionPage(category: selectedCategory, difficulty: selectedDifficulty),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
