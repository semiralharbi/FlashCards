import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.d12,
        ),
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: SizedBox(
            height: AppDimensions.d50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: AppColors.daintree),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
