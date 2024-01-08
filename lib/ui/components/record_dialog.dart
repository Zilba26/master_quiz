import 'package:flutter/material.dart';

class RecordDialog extends StatelessWidget {

  final int score;

  const RecordDialog({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quiz terminé', style: TextStyle(fontSize: 28),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Score: $score", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
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
              Navigator.pop(context, false);
              //Navigator.pop(context);
            },
            child: const Text('Accueil')
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Rejouer')
        )
      ],
    );
  }
}
