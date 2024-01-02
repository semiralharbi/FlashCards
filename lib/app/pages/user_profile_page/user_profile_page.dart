import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_settings_tile.dart';
import '../../widgets/progress_conrainer.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/user_profile_cubit.dart';
import 'cubit/user_profile_state.dart';

@RoutePage()
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withAppBar: false,
      child: BlocProvider(
        create: (context) => getIt<UserProfileCubit>(),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) => state.maybeWhen(
            loaded: (username, error) => _Body(username, error),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            loaded: (username, error) => _Body(username, error),
            orElse: () => const AppProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.username, this.usernameError);

  final String? username;
  final Errors? usernameError;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  "${context.tr.hi} UserName",
                  style: context.tht.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.draw_outlined)),
            ],
          ),
          const Text(
            'email@gmail.com',
            textAlign: TextAlign.center,
          ),
          const Gap(AppDimensions.d20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Twój progres:',
              textAlign: TextAlign.left,
              style: context.tht.displayMedium,
            ),
          ),
          const Divider(),
          const Row(
            children: [
              ProgressContainer(
                information: 'Ukończone foldery',
                progress: 10,
              ),
              ProgressContainer(
                information: '% postępu',
                progress: 7,
              ),
              ProgressContainer(
                information: 'Utworzonych słów',
                progress: 1000,
              ),
            ],
          ),
          const Gap(AppDimensions.d30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ustawienia:',
              textAlign: TextAlign.left,
              style: context.tht.displayMedium,
            ),
          ),
          const Divider(),
          const CustomSettingsTile(
            title: 'Twój język ojczysty',
          ),
          const Gap(AppDimensions.d10),
          const CustomSettingsTile(
            title: 'Twój język do nauki',
          ),
          const Gap(AppDimensions.d10),
          const CustomSettingsTile(
            title: 'Język splikacji',
          ),
          const Gap(AppDimensions.d50),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: InkWell(
              onTap: () {},
              child: Text(
                'Wyloguj się',
                style: context.tht.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: InkWell(
              onTap: () {},
              child: Text(
                'Zmień hasło',
                style: context.tht.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.d8),
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Usuń konto',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
