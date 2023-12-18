import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String text;

  const MainButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))))
        ),
        child: Text(text, style: const TextStyle(fontSize: 22, color: Colors.white))
    );
  }
}
