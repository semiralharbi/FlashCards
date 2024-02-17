import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../add_folder_words_page/cubit/add_folder_words_cubit.dart';
import 'widgets/country_button.dart';

@RoutePage()
class CreateFolderPage extends StatelessWidget {
  const CreateFolderPage({
    super.key,
    required this.folderName,
    this.cubit,
  });

  final String folderName;
  final AddFolderWordsCubit? cubit;

  @override
  Widget build(BuildContext context) => AppScaffold(
        appBarTitle: folderName,
        drawer: const CustomDrawer(),
        onlyBottomWood: true,
        child: BlocProvider(
          create: (context) => cubit ?? getIt<AddFolderWordsCubit>(),
          child: _Body(folderName, 'pl'),
        ),
      );
}

class _Body extends StatefulWidget {
  const _Body(this.folderName, this.initialCountryCode);

  final String folderName;
  final String initialCountryCode;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late String _targetLanguage;
  late String _sourceLanguage;

  @override
  void initState() {
    _targetLanguage = widget.initialCountryCode;
    _sourceLanguage = widget.initialCountryCode;
    super.initState();
  }

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
              setState(() {
                _targetLanguage = countryCode;
              });
            },
          ),
          Text(
            context.tr.createFolderPage_targetLanguageText,
            style: context.tht.displaySmall,
          ),
          CountryButton(
            initialCountryCode: 'PL',
            onSelect: (countryCode) {
              setState(() {
                _sourceLanguage = countryCode;
              });
            },
            width: AppDimensions.d10,
            height: AppDimensions.d10,
          ),
        ].animate().slideX().fade(),
        const Gap(AppDimensions.d20),
        TextButton(
          onPressed: () {
            context.read<AddFolderWordsCubit>().createFolder(
                  sourceLanguage: _sourceLanguage,
                  targetLanguage: _targetLanguage,
                  folderName: widget.folderName,
                );
            context.router.push(
              AddFolderWordsRoute(
                folderName: widget.folderName,
                targetLanguage: _targetLanguage,
                sourceLanguage: _sourceLanguage,
              ), //TODO: Take languages from entity
            );
          },
          child: Text(
            context.tr.createFolderPage_continueButtonText,
            style: context.tht.displayMedium,
          ),
        ).animate(delay: 400.ms).slideX().fade(),
      ],
    );
  }
}
