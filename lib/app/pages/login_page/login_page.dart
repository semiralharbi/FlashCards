import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';
import 'widgets/login_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, @visibleForTesting this.cubit});

  final LoginCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => cubit ?? getIt<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) => state.whenOrNull(
            showUsernamePage: () => context.router.push(UsernameRoute()),
            showHomePage: () => context.router.replaceAll([HomeRoute()]),
            fail: (error) => showAppSnackBar(
              context,
              error.errorText(context),
            ),
          ),
          builder: (context, state) => state.maybeWhen(
            loaded: (email, password) => _LoginPageBody(
              email: email,
              password: password,
            ),
            loading: () => const AppProgressIndicator(color: AppColors.daintree),
            orElse: _LoginPageBody.new,
          ),
        ),
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody({super.key, this.email, this.password});

  final String? email;
  final String? password;

  @override
  State<_LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(AppDimensions.d100),
          CustomTextField(
            controller: _emailController,
            hintText: context.tr.email,
          ),
          CustomTextField(
            controller: _passwordController,
            hintText: context.tr.password,
            hasPassword: true,
          ),
          const Gap(AppDimensions.d100),
          LoginButton(
            emailController: _emailController,
            passwordController: _passwordController,
          ).animate().fade(delay: 400.ms).slideX(delay: 400.ms),
          const Gap(AppDimensions.d20),
          AppElevatedButton(
            onPressed: () => context.router.push(RegistrationRoute()),
            text: context.tr.createAcc,
          ).animate().fade(delay: 600.ms).slideX(delay: 600.ms),
        ].animate().fade().slideY(curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
