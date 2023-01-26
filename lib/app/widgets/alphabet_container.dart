import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AlphabetContainer extends StatelessWidget {
  const AlphabetContainer({
    Key? key,
    required this.onPressed,
    required this.textStyleCondition,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool textStyleCondition;
  final String text;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: AppDimensions.d40,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.d44,
                ),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size?>(
              const Size(
                AppDimensions.d10,
                AppDimensions.d10,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.daintree,
              fontWeight: textStyleCondition ? FontWeight.bold : FontWeight.normal,
              fontSize: textStyleCondition ? AppDimensions.d18 : AppDimensions.d14,
            ),
          ),
        ),
      );
}
