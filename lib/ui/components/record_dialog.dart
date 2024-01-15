import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_quiz/constantes.dart';
import 'package:master_quiz/models/category.dart';
import 'package:master_quiz/models/difficulty.dart';
import 'package:master_quiz/ui/components/star_background.dart';

import '../../blocs/record_cubit.dart';

class RecordDialog extends StatelessWidget {

  final int score;
  final int maxScore;
  final Category category;
  final Difficulty difficulty;
  final bool? isRecord; //null value for equality

  const RecordDialog({super.key, required this.score, required this.category, required this.difficulty, required this.isRecord, required this.maxScore});

  String breakRecordText() {
    if (isRecord == null) {
      return "Vous avez égalé\nvotre record";
    } else if (isRecord!) {
      return "Vous avez battu\nvotre record 😀";
    } else {
      return "Vous n'avez pas battu\nvotre record 😔";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: BlocBuilder<RecordCubit, Map<int, Map<int, int?>>>(
        builder: (context, state) {
          return StarBackground(
            animated: false,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quiz terminé',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), // Texte en blanc
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Score: $score", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                          TextSpan(text: " / $maxScore", style: const TextStyle(fontSize: 18, color: Colors.white))
                        ]
                      )
                    ),
                    const SizedBox(height: 20),
                    Text(breakRecordText(),
                        style: const TextStyle(fontSize: 17, color: Colors.white), textAlign: TextAlign.center,),
                    const SizedBox(height: 20),
                    BlocBuilder<RecordCubit, Map<int, Map<int, int?>>>(
                      builder: (context, state) {
                        return Text('${(isRecord != null && isRecord!) ? "Nouveau Record" : "Record Actuel"} : ${state[category.index]![difficulty.index]?.toString()}',
                          style: const TextStyle(fontSize: 22.0, color: Colors.white),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                            Navigator.pop(context);
                          },
                          child: const Text('ACCUEIL', style: TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('REJOUER', style: TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
