import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import '../theme/app_paths.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    Key? key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppPaths.wood,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
                minimum: const EdgeInsets.all(
                  AppDimensions.d20,
                ),
                child: child),
          ],
        ),
      );
}
