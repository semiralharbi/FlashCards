import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_icon_text_button.dart';
import '../../widgets/password_texfield_widget.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/login_page_cubit.dart';
import 'cubit/login_page_state.dart';
import 'widgets/login_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => getIt<LoginPageCubit>(),
        child: BlocConsumer<LoginPageCubit, LoginPageState>(
          listener: (context, state) => state.whenOrNull(
            showUsernamePage: () => context.router.push(const UsernameRoute()),
            showHomePage: () => context.router.replaceAll([HomeRoute()]),
            fail: (error) => error != null
                ? showAppSnackBar(
                    context,
                    error.errorText(context),
                  )
                : showAppSnackBar(
                    context,
                    context.tr.unknownError,
                  ),
          ),
          builder: (context, state) => state.maybeWhen(
            initial: (email, password) => _LoginPageBody(
              email: email,
              password: password,
            ),
            loading: () => const AppProgressIndicator(
              color: AppColors.daintree,
            ),
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
          TextFieldWidget(
            controller: _emailController,
            hintText: context.tr.email,
          ),
          PasswordTextFieldWidget(
            controller: _passwordController,
            hintText: context.tr.password,
          ),
          const Gap(AppDimensions.d100),
          LoginButton(
            emailController: _emailController,
            passwordController: _passwordController,
          ).animate().fade(delay: 400.ms).slideX(delay: 400.ms),
          const Gap(AppDimensions.d40),
          CustomIconTextButton(
            onPressed: () => context.router.push(const RegistrationRoute()),
            icon: Icons.account_box,
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
