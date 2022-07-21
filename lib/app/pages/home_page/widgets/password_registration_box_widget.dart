import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../utils/translation/generated/l10n.dart';
import '../../../widgets/lower_box.dart';
import '../../../widgets/textfield_widget.dart';

class PasswordRegistrationBoxWidget extends StatelessWidget {
  const PasswordRegistrationBoxWidget({
    required this.passwordAnimationValue,
    required this.onTap,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool passwordAnimationValue;
  final Function() onTap;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => LowerBox(
        child: Stack(
          children: [
            Positioned(
              top: AppDimensions.d4,
              right: AppDimensions.d1,
              left: AppDimensions.d1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  Translation.of(context).registration,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.d20,
                        color: AppColors.cinnamon,
                      ),
                ),
              ),
            ),
            Positioned(
              right: AppDimensions.d1,
              left: AppDimensions.d1,
              top: AppDimensions.d30,
              child: TextFieldWidget(
                iconData: Icons.lock,
                controller: TextEditingController(),
                hintText: Translation.of(context).passwordInsert,
              ),
            ),
            Positioned(
              right: AppDimensions.d1,
              left: AppDimensions.d1,
              bottom: AppDimensions.d24,
              child: TextFieldWidget(
                iconData: Icons.lock,
                controller: TextEditingController(),
                hintText: Translation.of(context).passwordRepeat,
              ),
            ),
            Positioned(
              right: AppDimensions.d1,
              left: AppDimensions.d1,
              bottom: AppDimensions.d8,
              child: GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.d12,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Translation.of(context).goToRegister,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppDimensions.d14,
                            color: AppColors.cinnamon,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppDimensions.d86,
              right: AppDimensions.d4,
              left: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () => onPressed,
                  foregroundColor: AppColors.whiteSmoke,
                  backgroundColor: AppColors.cinnamon,
                  splashColor: AppColors.black,
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
