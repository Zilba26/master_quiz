import 'package:flutter/material.dart';
import 'package:master_quiz/ui/components/main_button.dart';

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fusee.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text("Master Quiz", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: MainButton(
                  onPressed:() {
                    Navigator.pushNamed(context, "choose_options");
                  }, text: 'Jouer', fontSize: 30,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
