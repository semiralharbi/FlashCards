import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/enums/context_extension.dart';

void showAppSnackBar(
  BuildContext context,
  String text, {
  int? seconds,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds ?? 1),
      backgroundColor: AppColors.whiteSmoke,
      content: Text(
        text,
        style: context.tht.bodyLarge?.copyWith(color: AppColors.red),
      ),
    ),
  );
}
