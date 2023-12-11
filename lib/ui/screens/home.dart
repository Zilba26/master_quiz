import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/images/logo.png"),
            ElevatedButton(
              onPressed:() {
                Navigator.pushNamed(context, "choose_options");
              },
              child: const Text("Jouer")
            )
          ],
        )
      ),
    );
  }
}
