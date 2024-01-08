import 'package:flutter/material.dart';

class ChooseOptions extends StatefulWidget {
  const ChooseOptions({Key? key}) : super(key: key);

  @override
  State<ChooseOptions> createState() => _ChooseOptionsState();
}

class _ChooseOptionsState extends State<ChooseOptions> {
  List<String> categories = ['Catégorie 1', 'Catégorie 2', 'Catégorie 3'];
  List<String> difficulties = ['Facile', 'Moyen', 'Difficile'];

  String selectedCategory = 'Catégorie 1';
  String selectedDifficulty = 'Facile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fusee.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sélectionnez la catégorie',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              // Sélecteur de catégorie
              DropdownButton<String>(
                value: selectedCategory,
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
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              // Sélecteur de difficulté
              DropdownButton<String>(
                value: selectedDifficulty,
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
              ElevatedButton(
                onPressed: () {
                  // Ajoutez ici le code pour traiter le bouton "Jouer"
                  // Utilisez les valeurs sélectionnées : selectedCategory et selectedDifficulty
                },
                child: Text('Jouer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
