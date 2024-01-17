import '../../../domain/entities/user/user_profile_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/user_profile_cubit.dart';
import 'cubit/user_profile_state.dart';
import 'widgets/account_section.dart';
import 'widgets/change_username_header.dart';
import 'widgets/progress_section.dart';
import 'widgets/settings_section.dart';
import 'widgets/username_header.dart';

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
              ChangeUsernameHeader(
                onTap: () {
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
              nativeCountryCode: widget.entity?.nativeLanguage ?? 'pl',
              appCountryCode: widget.entity?.appLanguage ?? 'pl',
              languageToLearnCountryCode: widget.entity?.languageToLearn ?? 'pl',
            ),
            const AccountSection(),
          ],
        ),
      ),
    );
  }
}
