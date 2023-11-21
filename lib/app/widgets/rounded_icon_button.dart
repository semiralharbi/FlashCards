import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    this.iconPadding,
    this.iconData,
    this.stringPath,
    this.buttonColor,
    this.iconColor,
    required this.onTap,
    this.elementHeight,
  });

  final EdgeInsetsGeometry? iconPadding;
  final String? stringPath;
  final IconData? iconData;
  final Color? buttonColor;
  final Color? iconColor;
  final VoidCallback onTap;
  final double? elementHeight;

  @override
  Widget build(BuildContext context) => Material(
        elevation: AppDimensions.d6,
        shape: CircleBorder(
          side: BorderSide(
            color: buttonColor != null ? AppColors.daintree : AppColors.whiteSmoke,
            width: AppDimensions.d3,
          ),
        ),
        color: buttonColor ?? AppColors.daintree,
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: AppColors.blueStone,
          onTap: onTap,
          child: Padding(
            padding: iconPadding ?? const EdgeInsets.all(AppDimensions.d18),
            child: stringPath != null
                ? Image.asset(
                    stringPath!,
                    height: elementHeight ?? AppDimensions.d44,
                    color: iconColor ?? AppColors.whiteSmoke,
                  )
                : Icon(
                    iconData,
                    size: elementHeight ?? AppDimensions.d64,
                    color: iconColor ?? AppColors.whiteSmoke,
                  ),
          ),
        ),
      );
}
