import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: AppColors.red),
      ),
    ),
  );
}
