import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../user_profile_page/cubit/user_profile_cubit.dart';
import 'widgets/country_button.dart';

@RoutePage()
class CreateFolderPage extends StatelessWidget {
  const CreateFolderPage({super.key, required this.folderName, this.cubit});

  final String folderName;
  final UserProfileCubit? cubit;

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: folderName,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
        child: BlocProvider(
          create: (context) => cubit ?? getIt<UserProfileCubit>(),
          child: Column(
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
                  initialCountryCode: 'US',
                  onSelect: (countryCode) =>
                      context.read<UserProfileCubit>().onUpdateNameButton(nativeLanguage: countryCode),
                ),
                Text(
                  context.tr.createFolderPage_targetLanguageText,
                  style: context.tht.displaySmall,
                ),
                CountryButton(
                  initialCountryCode: 'PL',
                  onSelect: (countryCode) =>
                      context.read<UserProfileCubit>().onUpdateNameButton(languageToLearn: countryCode),
                ),
              ].animate().slideX().fade(),
              const Gap(AppDimensions.d20),
              TextButton(
                onPressed: () => context.router.push(AddFolderWordsRoute(folderName: folderName)),
                child: Text(
                  context.tr.createFolderPage_continueButtonText,
                  style: context.tht.displayMedium,
                ),
              ).animate(delay: 400.ms).slideX().fade(),
            ],
          ),
        ),
      );
}
