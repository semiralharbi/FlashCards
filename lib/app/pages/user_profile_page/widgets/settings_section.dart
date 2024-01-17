import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../theme/global_imports.dart';
import '../../../widgets/custom_settings_tile.dart';
import '../cubit/user_profile_cubit.dart';
import 'category_text.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.nativeCountryCode,
    required this.appCountryCode,
    required this.languageToLearnCountryCode,
  });

  final String nativeCountryCode;
  final String appCountryCode;
  final String languageToLearnCountryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                countryCode: nativeCountryCode,
                onSelect: (countryCode) => context.read<UserProfileCubit>().onUpdateUserProfileButton(
                      entity: UserProfileEntity(nativeLanguage: countryCode),
                    ),
              ),
            ),
            const Gap(AppDimensions.d10),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d8),
              child: FlagTile(
                title: context.tr.userProfilePage_progressContainer_appLanguage,
                countryCode: appCountryCode,
                onSelect: (countryCode) => context.read<UserProfileCubit>().onUpdateUserProfileButton(
                      entity: UserProfileEntity(appLanguage: countryCode),
                    ),
              ),
            ),
            const Gap(AppDimensions.d10),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d8),
              child: FlagTile(
                title: context.tr.userProfilePage_progressContainer_languageToLearn,
                countryCode: languageToLearnCountryCode,
                onSelect: (countryCode) => context.read<UserProfileCubit>().onUpdateUserProfileButton(
                      entity: UserProfileEntity(languageToLearn: countryCode),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
