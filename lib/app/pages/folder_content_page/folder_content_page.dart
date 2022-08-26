import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/entities/database/flashcard_entity.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import 'widgets/folder_content_buttons.dart';
import 'widgets/words_container.dart';

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
        milliseconds: 600,
      ),
      initialValue: 0,
    );
    final getText = useState(false);

    return AppScaffold(
      appBarTitle: flashcardEntity.folderName.toUpperCase(),
      onlyBottomWood: true,
      drawer: const CustomDrawer(),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: flashcardEntity.words.length,
              itemBuilder: (context, index) => WordsContainer(
                flashcardEntity: flashcardEntity,
                animationController: animationController,
                index: index,
                value: getText.value,
              ),
            ),
          ),
          FolderContentButtons(
            animationController: animationController,
            getText: getText,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
