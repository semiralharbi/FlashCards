import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 40),
    this.constraints,
  });

  final String text;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Container(
            constraints: constraints ??
                const BoxConstraints(
                  minHeight: AppDimensions.d50,
                  minWidth: AppDimensions.d280,
                ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: context.tht.titleMedium?.copyWith(
                fontSize: AppDimensions.d14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
