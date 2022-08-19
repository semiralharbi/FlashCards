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
    this.onlyBottomWood = false,
  }) : super(key: key);

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final bool onlyBottomWood;

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
                padding: onlyBottomWood
                    ? const EdgeInsets.only(
                        bottom: AppDimensions.d80,
                      )
                    : const EdgeInsets.only(
                        bottom: AppDimensions.d80,
                        top: AppDimensions.d80,
                      ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppColors.whiteSmoke,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(
                        AppDimensions.d46,
                      ),
                      bottomRight: const Radius.circular(
                        AppDimensions.d46,
                      ),
                      topLeft: onlyBottomWood ? Radius.zero : const Radius.circular(
                        AppDimensions.d46,
                      ),
                      topRight: onlyBottomWood ? Radius.zero : const Radius.circular(
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
