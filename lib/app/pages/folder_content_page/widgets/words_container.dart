import '../../../../domain/entities/database/words_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/string_extensions.dart';
import '../../home_page/widgets/dismissible_background.dart';
import '../../home_page/widgets/folder_list_tile.dart';

class WordsContainer extends StatelessWidget {
  const WordsContainer({
    super.key,
    required this.wordNumber,
    required this.onDismissed,
    required this.wordsEntity,
  });

  final int wordNumber;
  final WordsEntity wordsEntity;
  final Function(DismissDirection) onDismissed;

  @override
  Widget build(BuildContext context) => FolderListTile(
        child: Dismissible(
          onDismissed: onDismissed,
          direction: DismissDirection.endToStart,
          key: key!,
          background: const DismissibleBackground(),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.d10) + const EdgeInsets.only(top: AppDimensions.d10),
            child: Row(
              children: [
                Text(
                  '${wordNumber + 1}.',
                  style: context.tht.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.d14,
                    color: AppColors.daintree,
                  ),
                ),
                const Gap(AppDimensions.d10),
                Expanded(
                  flex: 2,
                  child: Text(
                    wordsEntity.translatedWord.capitalize(),
                    style: context.tht.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(AppDimensions.d10),
                const Icon(
                  Icons.arrow_right_alt,
                  color: AppColors.daintree,
                ),
                const Gap(AppDimensions.d10),
                Expanded(
                  flex: 2,
                  child: Text(
                    wordsEntity.enWord.capitalize(),
                    style: context.tht.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ).animate(delay: 350.ms).slideX(),
                if (wordsEntity.correctAnswer ?? false) ...[
                  const Gap(AppDimensions.d10),
                  Image.asset(
                    Assets.png.check.path,
                    width: AppDimensions.d24,
                    height: AppDimensions.d24,
                  ),
                ],
              ],
            ).animate().fade(),
          ),
        ),
      );
}
