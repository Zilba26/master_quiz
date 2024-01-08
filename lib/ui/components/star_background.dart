import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';

class StarBackground extends StatelessWidget {
  final Widget child;
  final bool animated;
  StarBackground({super.key, required this.child, required this.animated});

  final SpriteSheet sparkleSpriteSheet = SpriteSheet(
    image: const AssetImage('assets/particle-21x23.png'),
    frameWidth: 21,
    length: 13,
  );

  @override
  Widget build(BuildContext context) {

    final ParticleField starField = ParticleField(
      spriteSheet: sparkleSpriteSheet,
      blendMode: BlendMode.dstIn,
      origin: Alignment.topLeft,
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        if (particles.isEmpty) {
          for (int i = 0; i < 150; i++) {
            particles.add(Particle(
              color: Colors.white,
              x: rnd(size.width),
              y: rnd(size.height),
              scale: Random().nextDouble() * 0.3 + 0.2,
              frame: Random().nextInt(sparkleSpriteSheet.length),
              vy: 5,
            ));
          }
        }
        if (animated) {
          particles.add(Particle(
            color: Colors.white,
            x: rnd(size.width),
            scale: rnd(0.2, 0.5),
            frame: rnd(sparkleSpriteSheet.length * 1.0).floor(),
            vy: 5,
          ));
          for (int i = particles.length - 1; i >= 0; i--) {
            Particle particle = particles[i];
            particle.update();
            if (!size.contains(particle.toOffset())) particles.removeAt(i);
          }
        }
      },
    );
    return starField.stackBelow(
      child: child
    );
  }
}
