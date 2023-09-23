import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/enums/context_extension.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({
    Key? key,
    required this.onTap,
    this.buttonPadding,
    this.textPadding,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  final VoidCallback onTap;
  final EdgeInsets? buttonPadding;
  final EdgeInsets? textPadding;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) => Padding(
        padding: buttonPadding ?? const EdgeInsets.only(bottom: AppDimensions.d24),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: textPadding,
            decoration: const BoxDecoration(
              color: AppColors.transparent,
              border: Border(
                top: BorderSide(color: Colors.black, width: 0.6),
              ),
            ),
            width: context.mqs.width,
            height: AppDimensions.d46,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: AppColors.daintree,
                  size: AppDimensions.d26,
                ),
                const SizedBox(
                  width: AppDimensions.d12,
                ),
                Text(
                  text,
                  style: context.tht.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.daintree,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
