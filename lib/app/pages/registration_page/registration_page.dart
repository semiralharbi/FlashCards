import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/enums/errors.dart';
import '../../utils/router/app_router.dart';
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
      withAppBar: false,
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
                    context.tr.unknownError,
                  ),
            registerSuccess: () => context.router.push(const UsernameRoute()),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            registerSuccess: () => const AppProgressIndicator(
              color: AppColors.daintree,
            ),
            loading: () => const AppProgressIndicator(
              color: AppColors.daintree,
            ),
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
    final obscurePassword = useState(true);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteSmoke,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimensions.d16,
              ),
            ),
          ),
          height: context.mqs.height / 1.6,
          width: context.mqs.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                context.tr.welcome,
                style: context.tht.headline4,
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
                      context.tr.goToLogin,
                      style: context.tht.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.d10,
                        color: AppColors.daintree,
                      ),
                    ),
                  ),
                ),
              ),
              TextFieldWidget(
                controller: emailController,
                error: emailError?.errorText(context),
                hintText: context.tr.email,
              ),
              PasswordTextFieldWidget(
                obscurePassword: obscurePassword,
                controller: passwordController,
                error: passwordError?.errorText(context),
                hintText: context.tr.password,
              ),
              PasswordTextFieldWidget(
                obscurePassword: obscurePassword,
                controller: repeatPasswordController,
                error: repeatPasswordError?.errorText(context),
                hintText: context.tr.passwordRepeat,
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.d40,
                ),
                child: AppElevatedButton(
                  onPressed: () => context.read<RegistrationPageCubit>().onRegisterClick(
                        email: emailController.text,
                        password: passwordController.text,
                        repeatPassword: repeatPasswordController.text,
                      ),
                  text: context.tr.registration,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
