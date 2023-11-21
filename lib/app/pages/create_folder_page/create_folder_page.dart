import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'widgets/country_button.dart';

@RoutePage()
class CreateFolderPage extends StatelessWidget {
  const CreateFolderPage({super.key, required this.folderName});

  final String folderName;

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: folderName,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
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
              const CountryButton(initialCountryCode: 'US'),
              Text(
                context.tr.createFolderPage_targetLanguageText,
                style: context.tht.displaySmall,
              ),
              const CountryButton(initialCountryCode: 'PL'),
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
      );
}
