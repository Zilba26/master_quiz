import 'dart:async';

import 'package:flutter/material.dart';
import 'package:master_quiz/ui/components/main_button.dart';
import 'package:master_quiz/ui/components/star_background.dart';
import 'package:newton_particles/newton_particles.dart';

import 'choose_options.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool launchAnimation = false;
  final animationDuration = const Duration(seconds: 5);

  Future<void> goToChooseOptionsPage() async {
    Future.delayed(animationDuration, () {
      launchAnimation = false;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChooseOptions()));
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
        child: StarBackground(
          animated: launchAnimation,
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: (height /2) - 187.5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/fusee-detouree.png", width: width * 0.7,)
                  )
                ),
                !launchAnimation ? Column(
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
                ) : const SizedBox(),
                launchAnimation ? Positioned.fill(
                  //duration: const Duration(seconds: 1),
                  top: (height /2) + 100,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Newton(
                      activeEffects: [
                        FountainEffect(
                          particleConfiguration: ParticleConfiguration(
                              shape: CircleShape(),
                              size: const Size(10, 10),
                              color: const SingleParticleColor(
                                  color: Colors.white
                              )
                          ),
                          effectConfiguration: const EffectConfiguration(),
                          width: width * 0.1,
                        )
                      ],
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
