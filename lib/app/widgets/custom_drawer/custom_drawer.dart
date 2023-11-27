import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injectable/injectable.dart';
import '../../pages/home_page/cubit/home_cubit.dart';
import '../../pages/home_page/cubit/home_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/router/app_router.dart';
import 'drawer_icon_button.dart';

class CustomDrawer extends Drawer {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<HomeCubit>(),
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) => state.maybeWhen(
            logout: () => context.router.replaceAll([
              const LoginRoute(),
            ]),
            orElse: () => null,
          ),
          child: const _Body(),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: AppColors.whiteSmoke,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: context.mqs.height * 0.3,
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
                height: context.mqs.height * 0.6,
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
                        onTap: () => context.router.push(
                          HomeRoute(),
                        ),
                        text: context.tr.yourFolders,
                        textPadding: const EdgeInsets.only(top: AppDimensions.d24),
                        iconData: Icons.folder_copy_outlined,
                      ),
                      DrawerIconButton(
                        onTap: () => context.router.push(const DictionaryRoute()),
                        text: context.tr.dictionary,
                        textPadding: const EdgeInsets.only(top: AppDimensions.d16),
                        iconData: Icons.abc,
                      ),
                      DrawerIconButton(
                        onTap: () => context.router.push(
                          HomeRoute(),
                        ),
                        text: context.tr.profile,
                        textPadding: const EdgeInsets.only(top: AppDimensions.d16),
                        iconData: Icons.person_outline,
                      ),
                      const Spacer(),
                      DrawerIconButton(
                        onTap: () => context.read<HomeCubit>().logout(),
                        text: context.tr.logOut,
                        textPadding: const EdgeInsets.only(top: AppDimensions.d16),
                        iconData: Icons.logout,
                      ),
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
                height: context.mqs.height * 0.2,
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
      );
}
