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

import 'cubit/registration_page_cubit.dart';
import 'cubit/registration_page_state.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocProvider(
        create: (context) => getIt<RegistrationPageCubit>(),
        child: BlocConsumer<RegistrationPageCubit, RegistrationPageState>(
          listener: (context, state) => state.mapOrNull(
            registerSuccess: (_) => const AppProgressIndicator(),
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
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.only(right: AppDimensions.d12),
                    width: AppDimensions.d110,
                    child: Text(
                      Translation.of(context).login,
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
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).password,
              ),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: Translation.of(context).passwordRepeat,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.d10,
                ),
                child: AppElevatedButton(
                  text: Translation.of(context).registration,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      );
}
