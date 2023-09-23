import 'package:flutter/material.dart';

class IntroFadeTransition extends StatelessWidget {
  const IntroFadeTransition({
    super.key,
    required this.animation,
    required this.text,
  });

  final Animation<double> animation;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
