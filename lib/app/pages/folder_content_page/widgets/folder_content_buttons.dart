import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../utils/translation/generated/l10n.dart';

class FolderContentButtons extends StatelessWidget {
  const FolderContentButtons({
    Key? key,
    required this.animationController,
    required this.getText,
    required this.onPressed,
  }) : super(key: key);

  final AnimationController animationController;
  final ValueNotifier<bool> getText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.d64,
        ),
        child: Row(
          children: [
            Material(
              elevation: AppDimensions.d8,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDimensions.d8,
                ),
              ),
              child: SizedBox(
                width: AppDimensions.d166,
                height: AppDimensions.d40,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    Translation.of(context).startFlashcard,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.d14,
                          color: AppColors.daintree,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Material(
              elevation: AppDimensions.d8,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDimensions.d8,
                ),
              ),
              child: SizedBox(
                height: AppDimensions.d40,
                child: ElevatedButton(
                  onPressed: () {
                    if (animationController.isAnimating == false) {
                      if (animationController.isCompleted) {
                        animationController.animateBack(
                          0,
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                        );
                        getText.value = false;
                      } else {
                        animationController.forward();
                        getText.value = true;
                      }
                    }
                  },
                  child: Text(
                    getText.value
                        ? Translation.of(context).hideAnswers
                        : Translation.of(context).uncoverAnswers,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.d14,
                          color: AppColors.daintree,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
