import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import '../theme/app_paths.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    Key? key,
    this.appBar,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: floatingActionButton,
        appBar: appBar,
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
