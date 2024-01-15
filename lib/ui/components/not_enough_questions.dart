import 'package:flutter/material.dart';

import '../screens/choose_options.dart';
import 'main_button.dart';

class NotEnoughQuestions extends StatelessWidget {
  const NotEnoughQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Pas de questions sur cette catégorie et cette difficulté pour le moment",
            style: TextStyle(color: Colors.white, fontSize: 24), textAlign: TextAlign.center,),
          const SizedBox(height: 50,),
          MainButton(text: "Retour à l'accueil", fontSize: 22, onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChooseOptions())))
        ],
      ),
    );
  }
}