import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/router/app_router.dart';
import '../../utils/translation/generated/l10n.dart';
import 'cubit/custom_drawer_cubit.dart';
import 'cubit/custom_drawer_state.dart';
import 'drawer_icon_button.dart';

class CustomDrawer extends Drawer {
  const CustomDrawer({
    Key? key,
    this.isHomePage = false,
    this.isProfilePage = false,
  }) : super(key: key);

  final bool isHomePage;
  final bool isProfilePage;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CustomDrawerCubit>(),
        child: BlocListener<CustomDrawerCubit, CustomDrawerState>(
          listener: (context, state) => state.maybeWhen(
            logout: () => context.router.popAndPushAll([
              const LoginRoute(),
            ]),
            orElse: () => null,
          ),
          child: Drawer(
            backgroundColor: AppColors.whiteSmoke,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(
                      color: AppColors.daintree,
                    ),
                  ),
                ),
                Positioned(
                  bottom: AppDimensions.d190,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: DrawerHeader(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.d16,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(AppDimensions.d28),
                          bottomLeft: Radius.circular(AppDimensions.d28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawerIconButton(
                            onTap: () => isHomePage
                                ? context.router.pop()
                                : context.router.pushAll([
                                    const HomeRoute(),
                                  ]),
                            text: Translation.of(context).yourFolders,
                            iconData: Icons.folder_copy_outlined,
                          ),
                          DrawerIconButton(
                            onTap: () => isProfilePage
                                ? context.router.pop()
                                : context.router.pushAll([
                                    const HomeRoute(),
                                  ]),
                            text: Translation.of(context).profile,
                            iconData: Icons.person_outline,
                          ),
                          const Spacer(),
                          DrawerIconButton(
                            onTap: () => context.read<CustomDrawerCubit>().logout(),
                            text: Translation.of(context).logOut,
                            iconData: Icons.logout,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: const BoxDecoration(
                      color: AppColors.daintree,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(AppDimensions.d28),
                        bottomLeft: Radius.circular(AppDimensions.d28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
