import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({
    Key? key,
    required this.onTap,
    this.padding,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  final VoidCallback onTap;
  final EdgeInsets? padding;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? const EdgeInsets.only(bottom: AppDimensions.d32),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.transparent,
              border: Border(
                top: BorderSide(color: Colors.black, width: 0.3),
              ),
            ),
            width: MediaQuery.of(context).size.width,
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
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
