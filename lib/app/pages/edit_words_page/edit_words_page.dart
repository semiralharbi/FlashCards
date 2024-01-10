import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/folder_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/string_extensions.dart';
import '../../utils/router/app_router.dart';
import '../../widgets/app_floating_action_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/custom_word_dialog.dart';
import '../../widgets/progress_indicator.dart';
import 'cubit/edit_words_cubit.dart';
import 'cubit/edit_words_state.dart';
import 'widgets/edit_word_container.dart';

@RoutePage()
class EditWordsPage extends HookWidget {
  const EditWordsPage({super.key, required this.flashcardEntity});

  final FolderEntity flashcardEntity;

  @override
  Widget build(BuildContext context) {
    final enWordController = useTextEditingController();
    final translatedWordController = useTextEditingController();
    final mounted = useIsMounted().call();
    return BlocProvider(
      create: (context) => getIt<EditWordsCubit>()..entityInit(flashcardEntity),
      child: BlocConsumer<EditWordsCubit, EditWordsState>(
        listener: (context, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),

          ///Pop used to dispose the dialog between states on error
          loading: (withPop) => withPop ? context.router.pop() : null,
          updateWordFailure: (emptyEnWord, emptyTranslatedWord) => showDialog(
            context: context,
            builder: (dialogContext) => CustomWordDialog(
              enWordController: enWordController,
              translatedWordController: translatedWordController,
              enWordError: emptyEnWord,
              translatedWordError: emptyTranslatedWord,
              onTap: () async {
                await context.read<EditWordsCubit>().updateWord(
                      enWordController.text,
                      translatedWordController.text,
                      flashcardEntity.folderName,
                    );
                if (!mounted) return;
                await dialogContext.router.pop(true);
              },
            ),
          ),
          onBackButton: (entity) => context.router.push(
            FolderContentRoute(folder: entity),
          ),
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: (_) => _LoadingBody(entity: flashcardEntity),
          onBackButton: (_) => _LoadingBody(entity: _),
          reload: (entity) => _Body(
            flashcardEntity: entity,
            enWordController: enWordController,
            translatedWordController: translatedWordController,
          ),
          initial: () => _Body(
            flashcardEntity: flashcardEntity,
            enWordController: enWordController,
            translatedWordController: translatedWordController,
          ),
          updateWordFailure: (_, __) => _Body(
            flashcardEntity: flashcardEntity,
            enWordController: enWordController,
            translatedWordController: translatedWordController,
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.flashcardEntity,
    required this.enWordController,
    required this.translatedWordController,
  });

  final FolderEntity flashcardEntity;
  final TextEditingController enWordController;
  final TextEditingController translatedWordController;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: AppFloatingActionButton(
        onPressed: () {
          enWordController.text = '';
          translatedWordController.text = '';
          showDialog(
            context: context,
            builder: (dialogContext) => CustomWordDialog(
              enWordController: enWordController,
              translatedWordController: translatedWordController,
              onTap: () async {
                await context.read<EditWordsCubit>().updateWord(
                      enWordController.text,
                      translatedWordController.text,
                      flashcardEntity.folderName,
                    );
              },
            ),
          );
        },
      ),
      appBarTitlePadding: const EdgeInsets.only(right: AppDimensions.d4),
      onBackPress: () => context.read<EditWordsCubit>().onBackButton(),
      actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
      ],
      appBarTitle: flashcardEntity.folderName.capitalize(),
      onlyBottomWood: true,
      drawer: const CustomDrawer(),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: flashcardEntity.words.length,
              itemBuilder: (context, index) => EditWordContainer(
                flashcardEntity: flashcardEntity,
                index: index,
                binIconTap: () => context.read<EditWordsCubit>().deleteWord(flashcardEntity, index),
                penIconTap: () => showDialog(
                  context: context,
                  builder: (dialog) {
                    enWordController.text = flashcardEntity.words[index].wordToTranslate;
                    translatedWordController.text = flashcardEntity.words[index].translatedWord;
                    return CustomWordDialog(
                      enWordController: enWordController,
                      translatedWordController: translatedWordController,
                      onTap: () async {
                        context.read<EditWordsCubit>().updateWord(
                              entity: flashcardEntity,
                              enWordController.text,
                              translatedWordController.text,
                              flashcardEntity.folderName,
                              isEditWord: true,
                              index: index,
                            );
                        await dialog.router.pop(true);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody({required this.entity});

  final FolderEntity entity;

  @override
  Widget build(BuildContext context) => AppScaffold(
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ),
        ],
        appBarTitle: entity.folderName.capitalize(),
        appBarTitlePadding: const EdgeInsets.only(right: AppDimensions.d4),
        onlyBottomWood: true,
        drawer: const CustomDrawer(),
        child: const AppProgressIndicator(
          color: AppColors.daintree,
        ),
      );
}
