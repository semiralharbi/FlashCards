import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.controller,
    required this.hintText,
    this.error,
    this.obscure = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.textInputAction,
    this.iconData,
  });

  final TextEditingController? controller;
  final String hintText;
  final bool obscure;
  final String? error;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            iconData,
            size: iconData != null ? AppDimensions.d50 : 0,
            color: AppColors.cinnamon,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.d12,
                bottom: AppDimensions.d8,
                right: AppDimensions.d12,
                left: AppDimensions.d12,
              ),
              child: TextField(
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                maxLength: maxLength,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                obscureText: obscure,
                controller: controller,
                style: const TextStyle(color: AppColors.cinnamon),
                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  counterText: '',
                  errorText: error,
                  filled: true,
                  fillColor: AppColors.whiteSmoke,
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimensions.d14,
                        color: AppColors.manatee,
                      ),
                  errorStyle: TextStyle(
                    height: 1,
                    color: AppColors.red,
                    fontSize: error != '' ? AppDimensions.d14 : 0,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.red,
                      width: 1,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.cinnamon),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.cinnamon,
                      width: AppDimensions.d2,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.cinnamon),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
