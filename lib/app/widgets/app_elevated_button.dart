import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

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
            width: context.mqs.width,
            child: Center(
              child: Text(
                text,
                style: context.tht.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
