import 'package:flutter/material.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/ui/components/main_button.dart';
import 'package:master_quiz/models/category.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 70.0),
                    const Text(
                      'Sélectionnez la catégorie',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20.0),
                    // Sélecteur de catégorie
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: bordersColor,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: DropdownButton<Category>(
                        value: selectedCategory,
                        underline: const SizedBox(),
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        dropdownColor: bordersColor,
                        onChanged: (Category? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                        items: categories.map<DropdownMenuItem<Category>>((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Sélectionnez la difficulté',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    // Sélecteur de difficulté
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: bordersColor,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: DropdownButton<Difficulty>(
                        value: selectedDifficulty,
                        underline: const SizedBox(),
                        style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        dropdownColor: bordersColor,
                        onChanged: (Difficulty? newValue) {
                          setState(() {
                            selectedDifficulty = newValue!;
                          });
                        },
                        items: difficulties.map<DropdownMenuItem<Difficulty>>((Difficulty value) {
                          return DropdownMenuItem<Difficulty>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
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
