import 'package:flutter/material.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../utils/enums/capitalize.dart';
import '../../../utils/enums/context_extension.dart';

class EditWordContainer extends StatelessWidget {
  const EditWordContainer({
    super.key,
    required this.flashcardEntity,
    required this.index,
    required this.binIconTap,
    required this.penIconTap,
  });

  final FlashcardEntity flashcardEntity;
  final int index;
  final VoidCallback binIconTap;
  final VoidCallback penIconTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: AppDimensions.d16,
        ),
        child: Material(
          elevation: AppDimensions.d8,
          color: AppColors.red,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimensions.d8,
            ),
          ),
          child: Container(
            width: context.mqs.width,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: AppDimensions.d8),
                Text(
                  '${index + 1}.',
                  style: context.tht.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.d14,
                    color: AppColors.daintree,
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                  width: context.mqs.width * 0.187,
                  child: Center(
                    child: Text(
                      flashcardEntity.words[index].translatedWord.capitalize(),
                      style: context.tht.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_right_alt,
                  color: AppColors.daintree,
                ),
                const Spacer(),
                SizedBox(
                  width: context.mqs.width * 0.187,
                  child: Center(
                    child: Text(
                      flashcardEntity.words[index].enWord.capitalize(),
                      style: context.tht.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                flashcardEntity.words[index].correctAnswer == true
                    ? Image.asset(
                        Assets.png.check.path,
                        width: AppDimensions.d24,
                        height: AppDimensions.d24,
                      )
                    : const SizedBox(
                        width: AppDimensions.d24,
                      ),
                SizedBox(
                  width: context.mqs.width * 0.02,
                ),
                SizedBox(
                  width: AppDimensions.d40,
                  child: IconButton(
                    onPressed: penIconTap,
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.daintree,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppDimensions.d40,
                  child: IconButton(
                    onPressed: binIconTap,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.milanoRed,
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.d10,
                ),
              ],
            ),
          ),
        ),
      );
}
