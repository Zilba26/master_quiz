import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_quiz/constantes.dart';
import 'package:master_quiz/models/category.dart';
import 'package:master_quiz/models/difficulty.dart';

import '../../blocs/record_cubit.dart';

class RecordDialog extends StatelessWidget {

  final int score;
  final Category category;
  final Difficulty difficulty;

  const RecordDialog({super.key, required this.score, required this.category, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Quiz terminé',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), // Texte en blanc
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Score: $score",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text("Vous avez battu votre record", style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 10),
          Column(
            children: [
              const Text(
                'Record Actuel',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              BlocBuilder<RecordCubit, Map<int, Map<int, int?>>>(
                builder: (context, state) {
                  return Text(
                    state[category.index]![difficulty.index]?.toString() ?? 'Aucun record',
                    style: const TextStyle(fontSize: 22.0, color: Colors.white),
                  );
                },
              )
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Accueil', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Rejouer', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
