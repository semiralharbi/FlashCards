import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../utils/translation/generated/l10n.dart';
import '../textfield_widget.dart';

class ListDialogContent extends HookWidget {
  const ListDialogContent({
    Key? key,
    required this.enWordController,
    required this.translatedController,
  }) : super(key: key);

  final TextEditingController enWordController;
  final TextEditingController translatedController;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.d18,
        ),
        child: Material(
          elevation: AppDimensions.d8,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimensions.d16,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              bottom: AppDimensions.d10,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteSmoke,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDimensions.d16,
                ),
              ),
              border: Border.all(
                color: AppColors.daintree,
              ),
            ),
            child: Column(
              children: [
                TextFieldWidget(
                  suffixIcon: const Icon(
                    Icons.drive_folder_upload,
                    size: AppDimensions.d44,
                    color: AppColors.daintree,
                  ),
                  controller: enWordController,
                  hintText: Translation.of(context).enWordDesc,
                ),
                TextFieldWidget(
                  suffixIcon: const Icon(
                    Icons.drive_folder_upload,
                    size: AppDimensions.d44,
                    color: AppColors.daintree,
                  ),
                  controller: translatedController,
                  hintText: Translation.of(context).translatedWordDesc,
                ),
              ],
            ),
          ),
        ),
      );
}
