import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/username_cubit.dart';
import 'cubit/username_state.dart';

@RoutePage()
class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key, @visibleForTesting this.cubit});

  final UsernameCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => cubit ?? getIt<UsernameCubit>(),
        child: BlocConsumer<UsernameCubit, UsernameState>(
          listener: (context, state) => state.whenOrNull(
            fail: (error) => showAppSnackBar(
              context,
              error.errorText(context),
            ),
            success: () => context.router.replaceAll([HomeRoute()]),
          ),
          builder: (context, state) => state.maybeWhen(
            success: () => const AppProgressIndicator(),
            loaded: (username, error) => _Body(
              username: username,
              usernameError: error,
            ),
            orElse: () => const AppProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({this.username, this.usernameError});

  final String? username;
  final Errors? usernameError;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(AppDimensions.d80),
          Text(
            context.tr.welcomeUser,
            style: context.tht.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(AppDimensions.d100),
          CustomTextField(
            controller: _usernameController,
            hintText: context.tr.username,
            error: widget.usernameError?.errorText(context),
          ),
          const Gap(AppDimensions.d152),
          AppElevatedButton(
            onPressed: () => context.read<UsernameCubit>().onUpdateButton(_usernameController.text),
            text: context.tr.continueNav,
          ),
        ],
      ),
    );
  }
}
