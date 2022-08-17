import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key? key,
    this.padding,
    this.iconData,
    this.stringPath,
    this.buttonColor,
    this.iconColor,
    required this.onTap,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final String? stringPath;
  final IconData? iconData;
  final Color? buttonColor;
  final Color? iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        shape: CircleBorder(
          side: BorderSide(
            color: buttonColor != null ? AppColors.daintree : AppColors.whiteSmoke,
            width: AppDimensions.d3,
          ),
        ),
        color: buttonColor ?? AppColors.daintree,
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: AppColors.cinnamon,
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppDimensions.d18),
            child: stringPath != null
                ? Image.asset(
                    stringPath!,
                    height: AppDimensions.d44,
                    color: iconColor ?? AppColors.whiteSmoke,
                  )
                : Icon(
                    iconData,
                    size: AppDimensions.d64,
                    color: iconColor ?? AppColors.whiteSmoke,
                  ),
          ),
        ),
      );
}
