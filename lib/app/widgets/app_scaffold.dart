import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_paths.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    Key? key,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
  }) : super(key: key);

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Drawer? drawer;

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: drawer,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.d80,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteSmoke,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        AppDimensions.d46,
                      ),
                      bottomRight: Radius.circular(
                        AppDimensions.d46,
                      ),
                    ),
                  ),
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
