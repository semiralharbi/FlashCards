import '../../../domain/entities/user/user_profile_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../user_profile_page/cubit/user_profile_cubit.dart';
import 'widgets/country_button.dart';

@RoutePage()
class CreateFolderPage extends StatefulWidget {
  const CreateFolderPage({
    super.key,
    required this.folderName,
    this.cubit,
  });

  final String folderName;
  final UserProfileCubit? cubit;

  @override
  State<CreateFolderPage> createState() => _CreateFolderPageState();
}

class _CreateFolderPageState extends State<CreateFolderPage> {
  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: widget.folderName,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
        child: BlocProvider(
          create: (context) => widget.cubit ?? getIt<UserProfileCubit>(),
          child: _Body(widget: widget),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({required this.widget});

  final CreateFolderPage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...[
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.d16),
            child: Text(
              context.tr.createFolderPage_welcomeText,
              style: context.tht.displaySmall?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            context.tr.createFolderPage_sourceLanguageText,
            style: context.tht.displaySmall,
          ),
          CountryButton(
            width: AppDimensions.d10,
            height: AppDimensions.d10,
            initialCountryCode: 'US', //TODO: TAKE IT FROM ENTITY
            onSelect: (countryCode) {
              return context.read<UserProfileCubit>().onUpdateUserProfileButton(
                    entity: UserProfileEntity(nativeLanguage: countryCode),
                  );
            },
          ),
          Text(
            context.tr.createFolderPage_targetLanguageText,
            style: context.tht.displaySmall,
          ),
          CountryButton(
            initialCountryCode: 'PL',
            onSelect: (countryCode) {
              context.read<UserProfileCubit>().onUpdateUserProfileButton(
                    entity: UserProfileEntity(
                      languageToLearn: countryCode,
                    ),
                  );
            },
            width: AppDimensions.d10,
            height: AppDimensions.d10,
          ),
        ].animate().slideX().fade(),
        const Gap(AppDimensions.d20),
        TextButton(
          onPressed: () => context.router.push(
            AddFolderWordsRoute(
              folderName: widget.folderName,
              targetLanguage: 'en',
              sourceLanguage: 'pl',
            ), //TODO: Take languages from entity
          ),
          child: Text(
            context.tr.createFolderPage_continueButtonText,
            style: context.tht.displayMedium,
          ),
        ).animate(delay: 400.ms).slideX().fade(),
      ],
    );
  }
}
