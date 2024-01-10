import '../../../../domain/entities/database/words_entity.dart';
import '../../../theme/global_imports.dart';

class AddedWordCard extends StatelessWidget {
  const AddedWordCard({
    super.key,
    required this.wordsEntity,
  });

  final WordsEntity wordsEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.daintree,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.d4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              wordsEntity.wordToTranslate,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 10, color: AppColors.daintree),
            Text(
              wordsEntity.translatedWord,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
