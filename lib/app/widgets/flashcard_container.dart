import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/capitalize.dart';

class FlashcardContainer extends StatelessWidget {
  const FlashcardContainer({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: AppColors.whiteSmoke,
          border: Border.all(
            color: AppColors.daintree,
            width: AppDimensions.d8,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
        ),
        padding: const EdgeInsets.all(AppDimensions.d8),
        child: Center(
          child: Text(
            text.capitalize(),
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AppDimensions.d22,
                  color: AppColors.daintree,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
