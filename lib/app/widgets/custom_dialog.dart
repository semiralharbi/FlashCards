import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/translation/generated/l10n.dart';
import 'rounded_icon_button.dart';
import 'textfield_widget.dart';

class CustomDialog extends StatelessWidget {
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
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  suffixIcon: const Icon(
                    Icons.folder,
                    size: AppDimensions.d44,
                    color: AppColors.daintree,
                  ),
                  controller: controller,
                  hintText: Translation.of(context).folderName,
                ),
                const SizedBox(
                  height: AppDimensions.d12,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.d8,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RoundedIconButton(
                      elementHeight: AppDimensions.d36,
                      padding: const EdgeInsets.all(
                        AppDimensions.d12,
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
