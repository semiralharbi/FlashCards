import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'widgets/country_button.dart';

@RoutePage()
class CreateFolderPage extends StatefulWidget {
  const CreateFolderPage({
    super.key,
    required this.folderName,
    required this.sourceCountryCode,
    required this.targetCountryCode,
  });

  final String folderName;
  final String sourceCountryCode;
  final String targetCountryCode;

  @override
  State<CreateFolderPage> createState() => _CreateFolderPageState();
}

class _CreateFolderPageState extends State<CreateFolderPage> {
  late String _sourceCountryCode;
  late String _targetCountryCode;

  @override
  void initState() {
    _sourceCountryCode = widget.sourceCountryCode;
    _targetCountryCode = widget.targetCountryCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: widget.folderName,
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
              CountryButton(
                initialCountryCode: _sourceCountryCode,
                onSelect: (countryCode) {
                  _sourceCountryCode = countryCode;
                },
              ),
              Text(
                context.tr.createFolderPage_targetLanguageText,
                style: context.tht.displaySmall,
              ),
              CountryButton(
                initialCountryCode: _targetCountryCode,
                onSelect: (countryCode) {
                  _targetCountryCode = countryCode;
                },
              ),
            ].animate().slideX().fade(),
            const Gap(AppDimensions.d20),
            TextButton(
              onPressed: () => context.router.push(
                AddFolderWordsRoute(
                  folderName: widget.folderName,
                  sourceLanguage: _sourceCountryCode,
                  targetLanguage: _targetCountryCode,
                ),
              ),
              child: Text(
                context.tr.createFolderPage_continueButtonText,
                style: context.tht.displayMedium,
              ),
            ).animate(delay: 400.ms).slideX().fade(),
          ],
        ),
      );
}
