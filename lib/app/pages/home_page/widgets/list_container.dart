import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../utils/translation/generated/l10n.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({
    Key? key,
    this.onTap,
    required this.entityElement,
  }) : super(key: key);
  final VoidCallback? onTap;
  final FlashcardEntity? entityElement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.d8,
          vertical: AppDimensions.d8,
        ),
        child: Material(
          elevation: AppDimensions.d8,
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
                  entityElement?.folderName.toUpperCase() ?? '',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.of(context).yourProgress(
                        '${entityElement?.correctAnswers}',
                        '${entityElement?.words.length}',
                      ),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
                      percent: entityElement != null
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
    );
  }
}
