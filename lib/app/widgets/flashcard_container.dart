import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/capitalize.dart';
import '../utils/enums/context_extension.dart';

class FlashcardContainer extends StatelessWidget {
  const FlashcardContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    height: context.mqs.height * 0.3,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: AppDimensions.d6,
            ),
          ],
          color: AppColors.whiteSmoke,
          border: Border.all(
            color: AppColors.daintree,
            width: AppDimensions.d4,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text.capitalize(),
            style: context.tht.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AppDimensions.d22,
                  color: AppColors.daintree,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
