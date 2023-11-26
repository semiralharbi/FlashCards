import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/string_extensions.dart';

class FolderContainer extends StatelessWidget {
  const FolderContainer({
    super.key,
    this.onTap,
    required this.entityElement,
    required this.onDismissed,
  });
  final VoidCallback? onTap;
  final FlashcardEntity? entityElement;
  final Function(DismissDirection) onDismissed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDimensions.d16,
        ),
        child: Material(
          color: AppColors.red,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.d8),
          ),
          elevation: AppDimensions.d8,
          child: Dismissible(
            onDismissed: onDismissed,
            direction: DismissDirection.endToStart,
            key: key!,
            background: Container(
              decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppDimensions.d8,
                  ),
                ),
              ),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: AppDimensions.d12,
                  ),
                  child: Icon(
                    Icons.delete_forever,
                    size: AppDimensions.d36,
                    color: AppColors.whiteSmoke,
                  ),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: AppDimensions.d10),
              decoration: BoxDecoration(
                color: AppColors.whiteSmoke,
                border: Border.all(
                  width: 1.5,
                  color: AppColors.daintree,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.d8,
                  ),
                ),
              ),
              height: AppDimensions.d68,
              width: context.mqs.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.folder,
                    color: AppColors.blueStone,
                    size: AppDimensions.d44,
                  ),
                  const Spacer(),
                  Text(
                    entityElement?.folderName.capitalize() ?? '',
                    style: context.tht.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.d16,
                      color: AppColors.daintree,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.yourProgress(
                          '${entityElement?.correctAnswers ?? 0}',
                          '${entityElement?.words.length ?? 0}',
                        ),
                        style: context.tht.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.d10,
                          color: AppColors.daintree,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimensions.d6,
                      ),
                      const SizedBox(
                        height: AppDimensions.d6,
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        width: AppDimensions.d100,
                        lineHeight: AppDimensions.d14,
                        percent: entityElement != null && entityElement!.words.isNotEmpty
                            ? entityElement!.correctAnswers! / entityElement!.words.length
                            : 0,
                        backgroundColor: AppColors.altoDarker,
                        progressColor: AppColors.salem,
                        barRadius: const Radius.circular(
                          AppDimensions.d16,
                        ),
                        animation: true,
                        animationDuration: 1000,
                      ),
                      const SizedBox(
                        height: AppDimensions.d3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: AppDimensions.d16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
