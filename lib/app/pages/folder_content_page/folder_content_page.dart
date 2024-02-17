import '../../../domain/entities/database/folder_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/global_imports.dart';
import '../../utils/enums/string_extensions.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'cubit/folder_content_cubit.dart';
import 'cubit/folder_content_state.dart';
import 'widgets/words_container.dart';

@RoutePage()
class FolderContentPage extends StatelessWidget {
  @visibleForTesting
  const FolderContentPage({
    super.key,
    required this.folder,
    this.cubit,
  });

  final FolderEntity folder;
  final FolderContentCubit? cubit;

  @override
  Widget build(BuildContext context) => AppScaffold(
        drawer: const CustomDrawer(),
        appBarTitle: folder.folderName.capitalize(),
        onlyBottomWood: true,
        onBackPress: () => context.router.replace(HomeRoute()),
        child: BlocProvider(
          create: (context) => cubit ?? getIt<FolderContentCubit>(),
          child: BlocConsumer<FolderContentCubit, FolderContentState>(
            listener: (context, state) => state.whenOrNull(
              nextPage: (entity, index) => context.router.push(
                FlashcardRoute(flashcardEntity: entity, index: index),
              ),
            ),
            builder: (context, state) => state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loaded: (folder) => _Body(folder: folder),
              initial: () => _Body(folder: folder),
            ),
          ),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({required this.folder});

  final FolderEntity folder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: folder.words.length,
            itemBuilder: (context, index) => WordsContainer(
              key: UniqueKey(),
              onDismissed: (_) async {
                await context.read<FolderContentCubit>().deleteWord(folder, index);
              },
              wordNumber: index,
              wordsEntity: folder.words[index],
            ),
          ),
        ),
        const Gap(AppDimensions.d20),
        Row(
          children: [
            AppElevatedButton(
              constraints: const BoxConstraints(
                minHeight: AppDimensions.d50,
                maxWidth: AppDimensions.d120,
              ),
              padding: EdgeInsets.zero,
              onPressed: () => context.router.push(
                EditWordsRoute(flashcardEntity: folder),
              ),
              text: context.tr.folderContentPage_editWords,
            ),
            const Gap(AppDimensions.d20),
            AppElevatedButton(
              constraints: const BoxConstraints(
                minHeight: AppDimensions.d50,
                maxWidth: AppDimensions.d120,
              ),
              padding: EdgeInsets.zero,
              onPressed: () => context.read<FolderContentCubit>().nextPage(folder),
              text: context.tr.startFlashcard,
            ),
          ],
        ),
      ],
    );
  }
}
