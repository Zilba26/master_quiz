import 'package:flutter/material.dart';
import 'package:master_quiz/ui/components/main_button.dart';

import 'choose_options.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool launchAnimation = false;
  final animationDuration = const Duration(seconds: 2);

  Future<void> goToChooseOptionsPage() async {
    Future.delayed(animationDuration, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChooseOptions()));
      launchAnimation = false;
    });
    setState(() {
      launchAnimation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =  MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(7, 16, 42, 1),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedPositioned(
                top: launchAnimation ? -400 : (height /2) - 187.5,
                duration: animationDuration,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/fusee-detouree.png", width: width * 0.7,)
                )
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
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
                        goToChooseOptionsPage();
                      },
                      text: 'Jouer',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
