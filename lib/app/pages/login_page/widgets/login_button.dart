import '../../../../environment_config.dart';
import '../../../theme/global_imports.dart';
import '../../../widgets/app_elevated_button.dart';
import '../cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        emailController.text = EnvConfig.email;
        passwordController.text = EnvConfig.password;
      },
      child: AppElevatedButton(
        onPressed: () => context.read<LoginCubit>().onLoginButton(
              emailController.text,
              passwordController.text,
            ),
        text: context.tr.logIn,
      ),
    );
  }
}
