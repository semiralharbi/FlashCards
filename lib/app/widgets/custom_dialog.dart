import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';
import 'rounded_icon_button.dart';
import 'textfield_widget.dart';

class CustomDialog extends HookWidget {
  const CustomDialog({
    Key? key,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Center(
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppDimensions.d8,
              horizontal: AppDimensions.d6,
            ),
            decoration: const BoxDecoration(
              color: AppColors.whiteSmoke,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppDimensions.d16,
                ),
              ),
            ),
            height: context.mqs.height * 0.2,
            width: context.mqs.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  suffixIcon: const Icon(
                    Icons.folder_open,
                    size: AppDimensions.d36,
                    color: AppColors.daintree,
                  ),
                  controller: controller,
                  hintText: context.tr.folderName,
                ),
                const SizedBox(
                  height: AppDimensions.d12,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.d12,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RoundedIconButton(
                      buttonColor: AppColors.whiteSmoke,
                      iconColor: AppColors.daintree,
                      elementHeight: AppDimensions.d30,
                      iconPadding: const EdgeInsets.all(
                        AppDimensions.d10,
                      ),
                      onTap: onTap,
                      iconData: Icons.arrow_forward_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
