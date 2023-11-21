import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 48),
    child: FloatingActionButton(
      backgroundColor: AppColors.daintree,
      splashColor: AppColors.cinnamon,
      elevation: AppDimensions.d10,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    ),
  );
}
