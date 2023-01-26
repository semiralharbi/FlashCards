import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_paths.dart';
import '../utils/translation/generated/l10n.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    Key? key,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.onlyBottomWood = false,
    this.withAppBar = true,
    this.enableBackArrow = true,
    this.appBarTitle,
    this.onBackPress,
    this.actions,
    this.appBarTitlePadding,
  }) : super(key: key);

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final bool onlyBottomWood;
  final bool withAppBar;
  final bool enableBackArrow;
  final String? appBarTitle;
  final Function()? onBackPress;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? appBarTitlePadding;

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: drawer,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: floatingActionButton,
        appBar: withAppBar
            ? AppBar(
                backgroundColor: AppColors.daintree,
                actions: actions,
                title: Center(
                  child: Padding(
                    padding: appBarTitlePadding ?? EdgeInsets.zero,
                    child: Text(
                      appBarTitle ?? Translation.of(context).yourFolders,
                    ),
                  ),
                ),
                leading: enableBackArrow
                    ? IconButton(
                        icon: const Icon(
                          Icons.keyboard_return_outlined,
                        ),
                        onPressed: () =>
                            onBackPress != null ? onBackPress!() : context.router.pop(),
                      )
                    : const SizedBox.shrink(),
              )
            : null,
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
                      topLeft: onlyBottomWood
                          ? Radius.zero
                          : const Radius.circular(
                              AppDimensions.d46,
                            ),
                      topRight: onlyBottomWood
                          ? Radius.zero
                          : const Radius.circular(
                              AppDimensions.d46,
                            ),
                    ),
                  ),
                  child: SafeArea(
                    minimum: const EdgeInsets.all(
                      AppDimensions.d16,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
