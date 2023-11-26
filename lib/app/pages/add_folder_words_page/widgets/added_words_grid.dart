import '../../../../domain/entities/database/words_entity.dart';
import '../../../theme/consts.dart';
import '../../../theme/global_imports.dart';
import 'added_word_card.dart';

class AddedWordsGrid extends StatelessWidget {
  const AddedWordsGrid({
    super.key,
    required this.wordsList,
  });

  final List<WordsEntity> wordsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: wordsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.2,
              mainAxisSpacing: AppDimensions.d6,
              crossAxisSpacing: AppDimensions.d6,
            ),
            itemBuilder: (_, index) => AddedWordCard(
              wordsEntity: wordsList[index],
            ),
          ),
        ),
        const Divider(height: staticZero),
      ],
    );
  }
}
