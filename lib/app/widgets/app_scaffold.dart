import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import '../theme/app_paths.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              AppPaths.woodCards,
            ),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            minimum: const EdgeInsets.all(
              AppDimensions.d16,
            ),
            child: child,
          ),
        ),
      );
}
