import 'package:flutter/material.dart';

import '../../../../domain/entities/database/flashcard_entity.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../theme/app_paths.dart';
import '../../../utils/enums/capitalize.dart';
import '../../../utils/enums/context_extension.dart';

class WordsContainer extends StatelessWidget {
  const WordsContainer({
    Key? key,
    required this.flashcardEntity,
    required this.animationController,
    required this.index,
    required this.value,
    required this.onDismissed,
  }) : super(key: key);

  final FlashcardEntity flashcardEntity;
  final AnimationController animationController;
  final int index;
  final bool value;
  final Function(DismissDirection) onDismissed;

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
              child: Stack(
                children: [
                  Positioned(
                    bottom: AppDimensions.d24,
                    left: AppDimensions.d8,
                    child: Text(
                      '${index + 1}.',
                      style: context.tht.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.d14,
                        color: AppColors.daintree,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    left: value ? AppDimensions.d50 : context.mqs.width * 0.2,
                    top: AppDimensions.d14,
                    bottom: AppDimensions.d14,
                    child: SizedBox(
                      width: value ? AppDimensions.d80 : context.mqs.width * 0.5,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Text(
                            flashcardEntity.words[index].translatedWord.capitalize(),
                            style: context.tht.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.d14,
                              color: AppColors.daintree,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppDimensions.d146,
                    top: AppDimensions.d14,
                    bottom: AppDimensions.d14,
                    child: FadeTransition(
                      opacity: animationController,
                      child: const Icon(
                        Icons.arrow_right_alt,
                        color: AppColors.daintree,
                      ),
                    ),
                  ),
                  Positioned(
                    right: AppDimensions.d74,
                    top: AppDimensions.d14,
                    bottom: AppDimensions.d14,
                    child: FadeTransition(
                      opacity: animationController,
                      child: SizedBox(
                        width: AppDimensions.d80,
                        child: Center(
                          child: Text(
                            flashcardEntity.words[index].enWord.capitalize(),
                            style: context.tht.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.d14,
                              color: AppColors.daintree,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  flashcardEntity.words[index].correctAnswer == true
                      ? Positioned(
                          right: AppDimensions.d16,
                          bottom: AppDimensions.d22,
                          child: Image.asset(
                            AppPaths.check,
                            width: AppDimensions.d24,
                            height: AppDimensions.d24,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      );
}
