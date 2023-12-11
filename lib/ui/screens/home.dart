import 'package:flutter/material.dart';

import '../../constantes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/logo.png"),
              ElevatedButton(
                onPressed:() {
                  Navigator.pushNamed(context, "choose_options");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonPrimaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Jouer"),
              ),
            ],
          )
        ),
      ),
    );
  }
}
