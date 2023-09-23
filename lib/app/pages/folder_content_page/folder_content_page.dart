import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../../injectable/injectable.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/consts.dart';
import '../../utils/enums/capitalize.dart';
import '../../utils/router/app_router.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'cubit/folder_content_cubit.dart';
import 'cubit/folder_content_state.dart';
import 'widgets/folder_content_buttons.dart';
import 'widgets/words_container.dart';

@RoutePage()
class FolderContentPage extends HookWidget {
  const FolderContentPage({
    Key? key,
    required this.flashcardEntity,
  }) : super(key: key);

  final FlashcardEntity flashcardEntity;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(
        milliseconds: AppConst.milliseconds600,
      ),
      initialValue: AppConst.staticZero,
    );
    final getText = useState(false);

    return AppScaffold(
      appBarTitle: flashcardEntity.folderName.capitalize(),
      appBarTitlePadding: const EdgeInsets.only(left: AppDimensions.d44),
      onlyBottomWood: true,
      actions: [
        IconButton(
          onPressed: () => context.router.push(
            EditWordsRoute(flashcardEntity: flashcardEntity),
          ),
          icon: const Icon(Icons.edit),
        ),
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
      ],
      onBackPress: () => context.router.push(const HomeRoute()),
      drawer: const CustomDrawer(),
      child: BlocProvider(
        create: (context) => getIt<FolderContentCubit>(),
        child: BlocConsumer<FolderContentCubit, FolderContentState>(
          listener: (context, state) => state.maybeWhen(
            nextPage: (entity, index) => context.router.push(
              FlashcardRoute(
                flashcardEntity: entity,
                index: index,
              ),
            ),
            initial: () => _Body(
              flashcardEntity: flashcardEntity,
              animationController: animationController,
              getText: getText,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            reload: (entity) => _Body(
              flashcardEntity: entity,
              animationController: animationController,
              getText: getText,
            ),
            initial: () => _Body(
              flashcardEntity: flashcardEntity,
              animationController: animationController,
              getText: getText,
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.flashcardEntity,
    required this.animationController,
    required this.getText,
  }) : super(key: key);

  final FlashcardEntity flashcardEntity;
  final AnimationController animationController;
  final ValueNotifier<bool> getText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: flashcardEntity.words.length,
            itemBuilder: (context, index) => WordsContainer(
              key: UniqueKey(),
              onDismissed: (_) async {
                await context.read<FolderContentCubit>().deleteWord(flashcardEntity, index);
              },
              flashcardEntity: flashcardEntity,
              animationController: animationController,
              index: index,
              value: getText.value,
            ),
          ),
        ),
        FolderContentButtons(
          animationController: animationController,
          onChange: getText,
          onPressed: () => context.read<FolderContentCubit>().nextPage(
                flashcardEntity,
              ),
        ),
      ],
    );
  }
}
