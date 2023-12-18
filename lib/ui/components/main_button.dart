import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String text;
  final double fontSize;

  const MainButton({super.key, this.onPressed, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))))
        ),
        child: Text(text, style: TextStyle(fontSize: fontSize, color: Colors.white))
    );
  }
}
