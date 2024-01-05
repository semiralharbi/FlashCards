import 'package:country_flags/country_flags.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../domain/entities/database/words_entity.dart';

import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/errors.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/add_folder_words_cubit.dart';
import 'widgets/added_words_grid.dart';

@RoutePage()
class AddFolderWordsPage extends StatelessWidget {
  const AddFolderWordsPage({
    super.key,
    required this.folderName,
    @visibleForTesting this.cubit,
  });

  final AddFolderWordsCubit? cubit;
  final String folderName;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => cubit ?? getIt<AddFolderWordsCubit>(),
        child: AppScaffold(
          appBarTitle: folderName,
          drawer: const CustomDrawer(),
          onlyBottomWood: true,
          child: BlocConsumer<AddFolderWordsCubit, AddFolderWordsState>(
            listener: (context, state) => state.whenOrNull(
              success: () => context.router.push(HomeRoute()),
              failure: (error) => showAppSnackBar(context, error.errorText(context)),
            ),
            builder: (context, state) => state.maybeWhen(
              loaded: (wordsList) => _Body(
                folderName: folderName,
                wordsList: wordsList,
              ),
              orElse: () => const AppProgressIndicator(),
            ),
          ),
        ),
      );
}

class _Body extends StatefulWidget {
  const _Body({
    required this.folderName,
    required this.wordsList,
  });

  final String folderName;
  final List<WordsEntity> wordsList;

  //TODO:Add entity, which contains language

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late TextEditingController _initialWordController;
  late TextEditingController _translatedWordController;
  late bool _isInitialWordNotEmpty = false;
  String? _initialWordError;
  String? _translatedWordError;

  @override
  void initState() {
    _initialWordController = TextEditingController();
    _translatedWordController = TextEditingController();
    super.initState();
  }

  void _onChangedInitialWord(String? text) {
    setState(() {
      _isInitialWordNotEmpty = text?.isNotEmpty ?? false;
      _initialWordError = null;
    });
  }

  void _onChangedTranslatedWord(String? text) {
    if (text?.isNotEmpty ?? false) {
      setState(() {
        _translatedWordError = null;
      });
    }
  }

  bool _validateFields() {
    bool isValid = true;
    setState(() {
      if (_initialWordController.text.isEmpty) {
        _initialWordError = context.tr.addWordFolderPage_textFieldError;
        _translatedWordError = context.tr.addWordFolderPage_textFieldError;
        isValid = false;
      } else {
        _initialWordError = null;
      }

      if (_translatedWordController.text.isEmpty) {
        _translatedWordError = context.tr.addWordFolderPage_textFieldError;
        isValid = false;
      } else {
        _translatedWordError = null;
      }
    });
    return isValid;
  }

  void _validateAndAddWord() {
    if (_validateFields()) {
      context.read<AddFolderWordsCubit>().addWord(
            WordsEntity(
              enWord: _initialWordController.text,
              translatedWord: _translatedWordController.text,
              nrRepeated: 0,
            ),
          );
      _resetState();
    }
  }

  void _resetState() {
    _initialWordController.clear();
    _translatedWordController.clear();
    setState(() {
      _isInitialWordNotEmpty = false;
    });
  }

  Future<void> _onTranslateTap() async {
    //TODO(): Add proper lang handling
    final translation =
        await getIt<GoogleTranslator>().translate(_initialWordController.text, from: 'pl'); // from: "entity.language"
    setState(() {
      _translatedWordController.text = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: AppDimensions.d244,
            child: widget.wordsList.isNotEmpty ? AddedWordsGrid(wordsList: widget.wordsList) : null,
          ),
          CustomTextField(
            prefix: Padding(
              padding: const EdgeInsets.only(top: AppDimensions.d8, right: AppDimensions.d8),
              child: CountryFlag.fromLanguageCode(
                'de',
                height: AppDimensions.d26,
                width: AppDimensions.d26,
              ), //TODO:Add flag
            ),
            error: _initialWordError,
            controller: _initialWordController,
            hintText: context.tr.translationWordDesc,
            onChanged: _onChangedInitialWord,
          ).animate().slideX().fade(),
          if (_isInitialWordNotEmpty)
            CustomTextField(
              prefix: Padding(
                padding: const EdgeInsets.only(top: AppDimensions.d10, right: AppDimensions.d8),
                child: CountryFlag.fromLanguageCode(
                  'en',
                  height: AppDimensions.d26,
                  width: AppDimensions.d26,
                ), //entity.language
              ),
              error: _translatedWordError,
              onChanged: _onChangedTranslatedWord,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.auto_fix_high_outlined,
                  color: AppColors.daintree,
                ),
                onPressed: _onTranslateTap,
              ),
              controller: _translatedWordController,
              hintText: context.tr.translatedWordDesc,
            ).animate().slideX().fade(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: _validateAndAddWord,
                child: Text(
                  context.tr.addWordFolderPage_addButtonText,
                  style: context.tht.displayMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  _validateAndAddWord();
                  context.read<AddFolderWordsCubit>().createFolder(folderName: widget.folderName);
                },
                child: Text(
                  context.tr.addWordFolderPage_finishButtonText,
                  style: context.tht.displayMedium,
                ),
              ),
            ],
          ).animate(delay: 400.ms).slideX().fade(),
        ],
      );

  @override
  void dispose() {
    _translatedWordController.dispose();
    _initialWordController.dispose();
    super.dispose();
  }
}
