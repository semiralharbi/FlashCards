import '../../../domain/entities/user/user_profile_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/category_text_widget.dart';
import '../../widgets/change_user_name_tile.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_settings_tile.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/progress_conrainer.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/user_name_tile.dart';
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
      drawer: const CustomDrawer(),
      child: BlocProvider(
        create: (context) => cubit ?? getIt<UserProfileCubit>()
          ..getUserProfile(),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) => state.whenOrNull(
            loaded: (entity) => _Body(
              entity: entity,
            ),
            fail: (error) => showAppSnackBar(context, error.errorText(context)),
            success: () => context.router.push(
              LoginRoute(),
            ),
          ),
          builder: (context, state) => state.maybeWhen(
            loaded: (entity) => _Body(
              entity: entity,
            ),
            loading: () => const AppProgressIndicator(),
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
    this.entity,
  });

  final UserProfileEntity? entity;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isEditMode = false;
  late final TextEditingController _usernameTextController;
  late final TextEditingController _emailChangePassword;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailChangePassword = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailChangePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            if (!isEditMode)
              UserNameTile(
                userName: "${context.tr.userProfilePage_hi}, ${widget.entity?.name ?? ''}",
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                  child: const Icon(Icons.draw_outlined),
                ),
              )
            else
              ChangeUserNameTile(
                textField: CustomTextField(
                  controller: _usernameTextController,
                  maxLength: 10,
                  hintText: context.tr.userProfilePage_textField,
                ),
                buttonToApprove: GestureDetector(
                  onTap: () {
                    context.read<UserProfileCubit>().onUpdateUserProfileButton(username: _usernameTextController.text);
                    setState(
                      () {
                        isEditMode = !isEditMode;
                        _usernameTextController.clear();
                      },
                    );
                  },
                  child: const Icon(Icons.check),
                ),
                buttonToPop: GestureDetector(
                  onTap: () {
                    context.router.pop();
                    setState(() {
                      isEditMode = !isEditMode;
                      _usernameTextController.clear();
                    });
                  },
                  child: const Icon(Icons.cancel),
                ),
              ),
            const Divider(),
            Text(
              " ${widget.entity?.email ?? ''}",
              textAlign: TextAlign.start,
            ),
            const Gap(AppDimensions.d20),
            CategoryTextWidget(
              categoryText: context.tr.userProfilePage_yourProgress,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            CategoryTextWidget(
              categoryText: context.tr.userProfilePage_settings,
            ),
            const Divider(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: FlagTile(
                    title: context.tr.userProfilePage_progressContainer_yourNativeLanguage,
                    countryCode: widget.entity?.nativeLanguage ?? 'pl',
                    onSelect: (countryCode) =>
                        context.read<UserProfileCubit>().onUpdateUserProfileButton(nativeLanguage: countryCode),
                    flagWidth: AppDimensions.d60,
                    flagHeight: AppDimensions.d60,
                  ),
                ),
                const Gap(AppDimensions.d10),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: FlagTile(
                    title: context.tr.userProfilePage_progressContainer_appLanguage,
                    countryCode: widget.entity?.nativeLanguage ?? 'pl',
                    onSelect: (countryCode) =>
                        context.read<UserProfileCubit>().onUpdateUserProfileButton(appLanguage: countryCode),
                    flagWidth: AppDimensions.d60,
                    flagHeight: AppDimensions.d60,
                  ),
                ),
                const Gap(AppDimensions.d10),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: FlagTile(
                    flagWidth: AppDimensions.d60,
                    flagHeight: AppDimensions.d60,
                    title: context.tr.userProfilePage_progressContainer_languageToLearn,
                    countryCode: widget.entity?.nativeLanguage ?? 'pl',
                    onSelect: (countryCode) =>
                        context.read<UserProfileCubit>().onUpdateUserProfileButton(languageToLearn: countryCode),
                  ),
                ),
                const Gap(AppDimensions.d50),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: CustomTextButton(
                    action: () => context.read<UserProfileCubit>().onSignOutButton(),
                    text: context.tr.userProfilePage_logoutButton,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: CustomTextButton(
                    action: () => _onTapChangePassword(),
                    text: context.tr.userProfilePage_changePasswordButton,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.d8),
                  child: CustomTextButton(
                    action: () => _onDeleteAccountDecision(),
                    text: context.tr.userProfilePage_deleteAccount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDeleteAccountDecision() {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        onPressed: () {
          context.read<UserProfileCubit>().onDeleteAccount();
        },
        information: context.tr.userProfilePage_deleteAccountDialogInformation,
        child: Text(context.tr.userProfilePage_deleteAccount),
      ),
    );
  }

  void _onTapChangePassword() {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        onPressed: () {
          context.read<UserProfileCubit>().onResetPassword(_emailChangePassword.text);
          context.router.pop();
        },
        information: context.tr.userProfilePage_changePasswordDialogInformation,
        child: CustomTextField(
          textFieldPadding: EdgeInsets.zero,
          controller: _emailChangePassword,
          hintText: context.tr.userProfilePage_writeDownYourEmail,
        ),
      ),
    );
  }
}
