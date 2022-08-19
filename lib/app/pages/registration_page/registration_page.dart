import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/errors.dart';
import '../../utils/router/app_router.dart';
import '../../utils/translation/generated/l10n.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/password_texfield_widget.dart';
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
          listener: (context, state) => state.maybeWhen(
            fail: (error) => error != null
                ? showAppSnackBar(
                    context,
                    error.errorText(context),
                  )
                : showAppSnackBar(
                    context,
                    Translation.of(context).unknownError,
                  ),
            registerSuccess: () => context.router.push(const UsernameRoute()),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            registerSuccess: () => const AppProgressIndicator(),
            initial: () => const _Body(),
            content: (
              email,
              password,
              repeatPassword,
              emailError,
              passwordError,
              repeatPasswordError,
            ) =>
                _Body(
              email: email,
              password: password,
              repeatPassword: repeatPassword,
              emailError: emailError,
              passwordError: passwordError,
              repeatPasswordError: repeatPasswordError,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
    this.email,
    this.password,
    this.repeatPassword,
    this.emailError,
    this.passwordError,
    this.repeatPasswordError,
  }) : super(key: key);

  final String? email;
  final String? password;
  final String? repeatPassword;
  final Errors? emailError;
  final Errors? passwordError;
  final Errors? repeatPasswordError;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: email);
    final passwordController = useTextEditingController(text: password);
    final repeatPasswordController = useTextEditingController(
      text: repeatPassword,
    );
    return Center(
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
                    color: AppColors.daintree,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.router.push(
                const LoginRoute(),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.d16,
                  ),
                  child: Text(
                    Translation.of(context).goToLogin,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.d12,
                          color: AppColors.daintree,
                        ),
                  ),
                ),
              ),
            ),
            TextFieldWidget(
              controller: emailController,
              error: emailError?.errorText(context),
              hintText: Translation.of(context).email,
            ),
            PasswordTextFieldWidget(
              controller: passwordController,
              error: passwordError?.errorText(context),
              hintText: Translation.of(context).password,
            ),
            PasswordTextFieldWidget(
              controller: repeatPasswordController,
              error: repeatPasswordError?.errorText(context),
              hintText: Translation.of(context).passwordRepeat,
            ),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.d10,
              ),
              child: AppElevatedButton(
                onPressed: () =>
                    context.read<RegistrationPageCubit>().onRegisterClick(
                          email: emailController.text,
                          password: passwordController.text,
                          repeatPassword: repeatPasswordController.text,
                        ),
                text: Translation.of(context).registration,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
