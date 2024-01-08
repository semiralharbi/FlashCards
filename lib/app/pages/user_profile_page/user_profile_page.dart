import '../../../domain/entities/user/user_profile_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_dialog_with_text_field.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_settings_tile.dart';
import '../../widgets/progress_conrainer.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/user_profile_cubit.dart';
import 'cubit/user_profile_state.dart';

@RoutePage()
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    this.cubit,
  });

  final UserProfileCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onlyBottomWood: true,
      drawer: const CustomDrawer(
        title: 'Twój profil',
      ),
      child: BlocProvider(
        create: (context) => cubit ?? getIt<UserProfileCubit>()
          ..init(),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) => state.maybeWhen(
            loaded: (entity, error) => _Body(
              usernameError: error,
              entity: entity,
            ),
            loading: () => const AppProgressIndicator(),
            orElse: () => const AppProgressIndicator(),
            fail: (error) => showAppSnackBar(context, error.errorText(context)),
            success: () => context.router.push(
              LoginRoute(),
            ),
          ),
          builder: (context, state) => state.maybeWhen(
            loaded: (entity, error) => _Body(
              usernameError: error,
              entity: entity,
            ),
            orElse: () => const AppProgressIndicator(),
            fail: (error) => const _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    this.usernameError,
    this.entity,
  });

  final UserProfileEntity? entity;
  final Errors? usernameError;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isEditMode = false;
  late final TextEditingController _textController;
  late final TextEditingController _emailToChangePassword;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _emailToChangePassword = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _emailToChangePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!isEditMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "${context.tr.userProfilePage_header}, ${widget.entity?.name ?? ''}",
                      style: context.tht.labelLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditMode = !isEditMode;
                      });
                    },
                    child: const Icon(Icons.draw_outlined),
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260,
                  height: 80,
                  child: TextField(
                    decoration: InputDecoration(labelText: context.tr.userProfilePage_textField),
                    textAlign: TextAlign.center,
                    controller: _textController,
                    maxLength: 10,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<UserProfileCubit>().onUpdateNameButton(_textController.text);
                          setState(() {
                            isEditMode = !isEditMode;
                            _textController.clear();
                          });
                        },
                        child: const Icon(Icons.check),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<UserProfileCubit>().onUpdateNameButton(_textController.text);
                          setState(() {
                            isEditMode = !isEditMode;
                            _textController.clear();
                          });
                        },
                        child: const Icon(Icons.cancel),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const Divider(),
          Text(
            " ${widget.entity?.email ?? ''}",
            textAlign: TextAlign.start,
          ),
          const Gap(AppDimensions.d20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.tr.userProfilePage_resume,
              textAlign: TextAlign.left,
              style: context.tht.displayMedium,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_foldersDone,
                progress: 10,
              ),
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_percentProgress,
                progress: 7,
              ),
              ProgressContainer(
                information: context.tr.userProfilePage_progressContainer_wordsCreated,
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
          Column(
            children: [
              CustomSettingsTile(
                title: context.tr.userProfilePage_progressContainer_yourNativeLanguage,
              ),
              const Gap(AppDimensions.d10),
              CustomSettingsTile(
                title: context.tr.userProfilePage_progressContainer_appLanguage,
              ),
              const Gap(AppDimensions.d10),
              CustomSettingsTile(
                title: context.tr.userProfilePage_progressContainer_languageToLearn,
              ),
              const Gap(AppDimensions.d50),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: InkWell(
                  onTap: () => context.read<UserProfileCubit>().onSignOutButton(),
                  child: Text(
                    context.tr.userProfilePage_logoutButton,
                    style: context.tht.titleMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => CustomDialogWithTextField(
                      controller: _emailToChangePassword,
                      onPressed: () {
                        context.read<UserProfileCubit>().onResetPassword(_emailToChangePassword.text);
                        context.router.pop();
                      },
                    ),
                  ),
                  child: Text(
                    context.tr.userProfilePage_changePasswordButton,
                    style: context.tht.titleMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.d8),
                child: InkWell(
                  onTap: () {
                    context.read<UserProfileCubit>().onDeleteAccount();
                  },
                  child: Text(
                    context.tr.userProfilePage_deleteAccount,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}