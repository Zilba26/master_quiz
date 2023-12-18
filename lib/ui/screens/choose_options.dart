import 'package:flutter/material.dart';
import 'package:master_quiz/ui/components/main_button.dart';
import 'package:master_quiz/models/category.dart';

import '../../constantes.dart';

class ChooseOptions extends StatefulWidget {
  const ChooseOptions({Key? key}) : super(key: key);

  @override
  State<ChooseOptions> createState() => _ChooseOptionsState();
}

class _ChooseOptionsState extends State<ChooseOptions> {
  List<String> categories = Category.values.map((e) => e.toString()).toList();
  List<String> difficulties = ['Facile', 'Moyen', 'Difficile'];

  String selectedCategory = Category.all.toString();
  String selectedDifficulty = 'Facile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sélectionnez la catégorie',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              // Sélecteur de catégorie
              DropdownButton<String>(
                value: selectedCategory,
                style: const TextStyle(color: Colors.white),
                dropdownColor: bordersColor,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const Text(
                'Sélectionnez la difficulté',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              // Sélecteur de difficulté
              DropdownButton<String>(
                value: selectedDifficulty,
                style: const TextStyle(color: Colors.white),
                dropdownColor: bordersColor,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDifficulty = newValue!;
                  });
                },
                items: difficulties.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              MainButton(
                text: 'Jouer',
                fontSize: 30.0,
                onPressed: () {
                  Navigator.pushNamed(context, "game", arguments: {
                    'category': selectedCategory,
                    'difficulty': selectedDifficulty
                  }
                  );
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
