import '../../../gen/fonts.gen.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/textfield_widget.dart';
import 'cubit/username_page_cubit.dart';
import 'cubit/username_page_state.dart';

@RoutePage()
class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => getIt<UsernamePageCubit>(),
        child: BlocConsumer<UsernamePageCubit, UsernamePageState>(
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
            success: () => context.router.replaceAll([HomeRoute()]),
          ),
          builder: (context, state) => state.maybeWhen(
            success: () => const AppProgressIndicator(),
            initial: (username) => _Body(
              username: username,
            ),
            orElse: () => const AppProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({this.username});

  final String? username;

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
          Text(
            context.tr.welcomeUser,
            style: context.tht.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: AppDimensions.d18,
              color: AppColors.daintree,
              fontFamily: FontFamily.gloriaHallelujah,
              letterSpacing: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppDimensions.d80),
          TextFieldWidget(
            controller: _usernameController,
            hintText: context.tr.username,
          ),
          const Gap(AppDimensions.d60),
          AppElevatedButton(
            onPressed: () => context.read<UsernamePageCubit>().onUpdateButton(_usernameController.text),
            text: context.tr.continueNav,
          ),
        ],
      ),
    );
  }
}
