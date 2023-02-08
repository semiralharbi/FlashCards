import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FoldAnimation extends HookWidget {
  const FoldAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0.0,
    );
    final Animation animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    return GestureDetector(
      onTap: () {
        if (controller.isCompleted) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.red,
              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(pi * animation.value),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
