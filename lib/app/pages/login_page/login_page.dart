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
import 'cubit/login_page_cubit.dart';
import 'cubit/login_page_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocProvider(
        create: (context) => getIt<LoginPageCubit>(),
        child: BlocConsumer<LoginPageCubit, LoginPageState>(
          listener: (context, state) => state.maybeWhen(
            loading: () => const AppProgressIndicator(),
            showUsernamePage: () => context.router.push(const UsernameRoute()),
            showHomePage: () => context.router.pushAll([const HomeRoute()]),
            fail: (error) => error != null
                ? showAppSnackBar(
                    context,
                    error.errorText(context),
                  )
                : showAppSnackBar(
                    context,
                    Translation.of(context).unknownError,
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            initial: (email, password) => _Body(
              email: email,
              password: password,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({this.email, this.password});

  final String? email;
  final String? password;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: email);
    final passwordController = useTextEditingController(text: password);
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
                          color: AppColors.daintree,
                        ),
                  ),
                ),
              ),
            ),
            TextFieldWidget(
              controller: emailController,
              hintText: Translation.of(context).email,
            ),
            PasswordTextFieldWidget(
              controller: passwordController,
              hintText: Translation.of(context).password,
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.d10,
              ),
              child: AppElevatedButton(
                onPressed: () => context.read<LoginPageCubit>().onLoginButton(
                      emailController.text,
                      passwordController.text,
                    ),
                text: Translation.of(context).logIn,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
