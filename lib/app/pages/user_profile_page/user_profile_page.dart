import '../../../domain/entities/user/user_profile_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/user_profile_cubit.dart';
import 'cubit/user_profile_state.dart';
import 'widgets/account_managment_widget.dart';
import 'widgets/change_user_name_tile.dart';
import 'widgets/progress_section_widget.dart';
import 'widgets/settings_section_widget.dart';
import 'widgets/user_name_header.dart';

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
              UserNameHeader(
                userName: "${context.tr.userProfilePage_hi}, ${widget.entity?.name ?? ''}",
                onEditonTap: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
              )
            else
              ChangeUserNameTile(
                textField: CustomTextField(
                  controller: _usernameTextController,
                  maxLength: 10,
                  hintText: context.tr.userProfilePage_textField,
                ),
                nameController: _usernameTextController,
                function: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
              ),
            const Divider(),
            Text(
              " ${widget.entity?.email ?? ''}",
              textAlign: TextAlign.start,
            ),
            const ProgressSection(),
            SettingsSection(
              nativeCountryCode: widget.entity?.nativeLanguage,
              appCountryCode: widget.entity?.appLanguage,
              languageToLearnCountryCode: widget.entity?.languageToLearn,
            ),
            AccountManagement(
              email: _emailChangePassword.text,
              controller: _emailChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}
