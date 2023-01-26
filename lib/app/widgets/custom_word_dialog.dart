import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/errors.dart';
import '../utils/translation/generated/l10n.dart';
import 'rounded_icon_button.dart';
import 'textfield_widget.dart';

class CustomWordDialog extends StatelessWidget {
  const CustomWordDialog({
    Key? key,
    required this.enWordController,
    required this.translatedWordController,
    required this.onTap,
    this.translatedWordError = false,
    this.enWordError = false,
  }) : super(key: key);

  final TextEditingController enWordController;
  final TextEditingController translatedWordController;
  final VoidCallback onTap;
  final bool translatedWordError;
  final bool enWordError;

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
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  error: enWordError ? Errors.fieldCantBeEmpty.errorText(context) : null,
                  controller: enWordController,
                  hintText: Translation.of(context).enWordDesc,
                ),
                TextFieldWidget(
                  error: translatedWordError ? Errors.fieldCantBeEmpty.errorText(context) : null,
                  controller: translatedWordController,
                  hintText: Translation.of(context).translatedWordDesc,
                ),
                translatedWordError || enWordError
                    ? const SizedBox()
                    : const SizedBox(
                        height: AppDimensions.d36,
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.d8,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RoundedIconButton(
                      elementHeight: AppDimensions.d28,
                      padding: const EdgeInsets.all(
                        AppDimensions.d12,
                      ),
                      onTap: onTap,
                      iconData: Icons.check,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
