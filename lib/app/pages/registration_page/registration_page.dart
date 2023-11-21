import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_icon_text_button.dart';
import '../../widgets/password_texfield_widget.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/registration_page_cubit.dart';
import 'cubit/registration_page_state.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => getIt<RegistrationPageCubit>(),
        child: BlocConsumer<RegistrationPageCubit, RegistrationPageState>(
          listener: (context, state) => state.whenOrNull(
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
          ),
          builder: (context, state) => state.maybeMap(
            orElse: () => const AppProgressIndicator(
              color: AppColors.daintree,
            ),
            initial: (state) => const _Body(),
            content: (state) => _Body(
              email: state.email,
              password: state.password,
              repeatPassword: state.repeatPassword,
              emailError: state.emailError,
              passwordError: state.passwordError,
              repeatPasswordError: state.repeatPasswordError,
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    this.email,
    this.password,
    this.repeatPassword,
    this.emailError,
    this.passwordError,
    this.repeatPasswordError,
  });

  final String? email;
  final String? password;
  final String? repeatPassword;
  final Errors? emailError;
  final Errors? passwordError;
  final Errors? repeatPasswordError;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _repeatPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController(text: widget.password);
    _repeatPasswordController = TextEditingController(text: widget.repeatPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWidget(
              controller: _emailController,
              error: widget.emailError?.errorText(context),
              hintText: context.tr.email,
            ),
            PasswordTextFieldWidget(
              controller: _passwordController,
              error: widget.passwordError?.errorText(context),
              hintText: context.tr.password,
            ),
            PasswordTextFieldWidget(
              controller: _repeatPasswordController,
              error: widget.repeatPasswordError?.errorText(context),
              hintText: context.tr.passwordRepeat,
            ),
            const Gap(AppDimensions.d100),
            AppElevatedButton(
              onPressed: () => context.read<RegistrationPageCubit>().onRegisterClick(
                    email: _emailController.text,
                    password: _passwordController.text,
                    repeatPassword: _repeatPasswordController.text,
                  ),
              text: context.tr.createAcc,
            ).animate().fade(delay: 400.ms).slideX(delay: 400.ms),
            const Gap(AppDimensions.d40),
            CustomIconTextButton(
              onPressed: () => context.router.pop(),
              icon: Icons.account_box,
              text: context.tr.logIn,
            ).animate().fade(delay: 600.ms).slideX(delay: 600.ms),
          ].animate().fade().slideY(curve: Curves.easeIn),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
}
