import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/home_page_cubit.dart';
import 'cubit/home_page_state.dart';
import 'widgets/email_registration_box_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocProvider(
        create: (context) => getIt<HomePageCubit>(),
        child: BlocConsumer<HomePageCubit, HomePageState>(
          listener: (context, state) => state.mapOrNull(
            loginSuccess: (_) => AppProgressIndicator(),
          ),
          builder: (context, state) => state.maybeWhen(
            initial: () => _Body(),
            register: () => EmailRegistrationBoxWidget(
              emailRegAnimationValue: true,
              onTap: () => context.read<HomePageCubit>().onGoToLoginClick(),
              onPressed: () =>
                  context.read<HomePageCubit>().onEmailRegisterClick(),
            ),
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
          height: MediaQuery.of(context).size.height / 1.3,
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
              Row(
                children: [
                  const SizedBox(
                    width: AppDimensions.d10,
                  ),
                  Expanded(
                    child: AppElevatedButton(
                      text: Translation.of(context).login,
                    ),
                  ),
                  const SizedBox(
                    width: AppDimensions.d10,
                  ),
                  Expanded(
                    child: AppElevatedButton(
                      text: Translation.of(context).registration,
                    ),
                  ),
                  const SizedBox(
                    width: AppDimensions.d10,
                  ),
                ],
              ),
              const Spacer(),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).email,
              ),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).password,
              ),
              const Spacer(flex: 5),
            ],
          ),
        ),
      );
}
