import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/router/app_router.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/password_texfield_widget.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/home_page_cubit.dart';
import 'cubit/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocProvider(
        create: (context) => getIt<HomePageCubit>(),
        child: BlocConsumer<HomePageCubit, HomePageState>(
          listener: (context, state) => state.mapOrNull(
            loginSuccess: (_) => const AppProgressIndicator(),
            register: (_) => context.router.push(const RegistrationRoute()),
          ),
          builder: (context, state) => state.maybeWhen(
            initial: () => _Body(),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteSmoke,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimensions.d16,
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height / 1.6,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                Translation.of(context).welcome,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.d18,
                      color: AppColors.cinnamon,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.router.push(const RegistrationRoute()),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.only(right: AppDimensions.d12),
                    width: AppDimensions.d110,
                    child: Text(
                      Translation.of(context).createAccount,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppDimensions.d12,
                            color: AppColors.cinnamon,
                          ),
                    ),
                  ),
                ),
              ),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).email,
              ),
              PasswordTextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).password,
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.d10,
                ),
                child: AppElevatedButton(
                  onPressed: () {},
                  text: Translation.of(context).logIn,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
