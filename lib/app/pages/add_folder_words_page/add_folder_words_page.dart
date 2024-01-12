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
    required this.targetLanguage,
    required this.sourceLanguage,
  });

  final AddFolderWordsCubit? cubit;
  final String folderName;
  final String sourceLanguage;
  final String targetLanguage;

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
                targetLanguage: targetLanguage,
                sourceLanguage: sourceLanguage,
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
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String folderName;
  final List<WordsEntity> wordsList;
  final String sourceLanguage;
  final String targetLanguage;

  //TODO:Add entity, which contains language

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late TextEditingController _sourceWordController;
  late TextEditingController _targetWordController;
  late bool _isSourceWordNotEmpty = false;
  String? _sourceWordError;
  String? _targetWordError;

  @override
  void initState() {
    _sourceWordController = TextEditingController();
    _targetWordController = TextEditingController();
    super.initState();
  }

  void _onChangedInitialWord(String? text) {
    setState(() {
      _isSourceWordNotEmpty = text?.isNotEmpty ?? false;
      _sourceWordError = null;
    });
  }

  void _onChangedTranslatedWord(String? text) {
    if (text?.isNotEmpty ?? false) {
      setState(() {
        _targetWordError = null;
      });
    }
  }

  bool _validateFields() {
    bool isValid = true;
    setState(() {
      if (_sourceWordController.text.isEmpty) {
        _sourceWordError = context.tr.addWordFolderPage_textFieldError;
        _targetWordError = context.tr.addWordFolderPage_textFieldError;
        isValid = false;
      } else {
        _sourceWordError = null;
      }

      if (_targetWordController.text.isEmpty) {
        _targetWordError = context.tr.addWordFolderPage_textFieldError;
        isValid = false;
      } else {
        _targetWordError = null;
      }
    });
    return isValid;
  }

  void _validateAndAddWord() {
    if (_validateFields()) {
      context.read<AddFolderWordsCubit>().addWord(
            WordsEntity(
              wordToTranslate: _sourceWordController.text,
              translatedWord: _targetWordController.text,
              nrRepeated: 0,
            ),
          );
      _resetState();
    }
  }

  void _resetState() {
    _sourceWordController.clear();
    _targetWordController.clear();
    setState(() {
      _isSourceWordNotEmpty = false;
    });
  }

  Future<void> _onTranslateTap() async {
    final translation = await getIt<GoogleTranslator>()
        .translate(_sourceWordController.text, from: 'pl'); //TODO:Add entity, which contains language
    setState(() {
      _targetWordController.text = translation.text;
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
            autofocus: true,
            leading: CountryFlag.fromLanguageCode(
              widget.sourceLanguage,
              height: AppDimensions.d26,
              width: AppDimensions.d26,
            ),
            error: _sourceWordError,
            controller: _sourceWordController,
            hintText: context.tr.translationWordDesc,
            onChanged: _onChangedInitialWord,
          ).animate().slideX().fade(),
          if (_isSourceWordNotEmpty)
            CustomTextField(
              leading: CountryFlag.fromLanguageCode(
                widget.targetLanguage,
                height: AppDimensions.d26,
                width: AppDimensions.d26,
              ),
              error: _targetWordError,
              onChanged: _onChangedTranslatedWord,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.auto_fix_high_outlined,
                  color: AppColors.daintree,
                ),
                onPressed: _onTranslateTap,
              ),
              controller: _targetWordController,
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
                  context.read<AddFolderWordsCubit>().createFolder(
                        folderName: widget.folderName,
                        sourceLanguage: widget.sourceLanguage,
                        targetLanguage: widget.targetLanguage,
                      );
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
    _targetWordController.dispose();
    _sourceWordController.dispose();
    super.dispose();
  }
}
