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
import 'cubit/login_page_cubit.dart';
import 'cubit/login_page_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => getIt<LoginPageCubit>(),
        child: BlocConsumer<LoginPageCubit, LoginPageState>(
          listener: (context, state) => state.maybeWhen(
            showUsernamePage: () => context.router.push(const UsernameRoute()),
            showHomePage: () => context.router.replaceAll([const HomeRoute()]),
            fail: (error) => error != null
                ? showAppSnackBar(
                    context,
                    error.errorText(context),
                  )
                : showAppSnackBar(
              context,
                    context.tr.unknownError,
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            initial: (email, password) => _Body(
              email: email,
              password: password,
            ),
            loading: () => const AppProgressIndicator(
              color: AppColors.daintree,
            ),
            orElse: _Body.new,
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
                onTap: () => context.router.push(const RegistrationRoute()),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.only(right: AppDimensions.d12),
                    width: AppDimensions.d110,
                    child: Text(
                      context.tr.createAccount,
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
                hintText: context.tr.email,
              ),
              PasswordTextFieldWidget(
                obscurePassword: obscurePassword,
                controller: passwordController,
                hintText: context.tr.password,
              ),
              SizedBox(
                height: context.mqs.height * 0.0958,
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.d40,
                ),
                child: AppElevatedButton(
                  onPressed: () => context.read<LoginPageCubit>().onLoginButton(
                        emailController.text,
                        passwordController.text,
                      ),
                  text: context.tr.logIn,
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
