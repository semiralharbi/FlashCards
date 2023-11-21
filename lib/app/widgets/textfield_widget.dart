import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

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
    this.textFieldPadding,
    super.key,
    this.onChanged,
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
  final EdgeInsets? textFieldPadding;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            iconData,
            size: iconData != null ? AppDimensions.d50 : 0,
            color: AppColors.daintree,
          ),
          Flexible(
            child: Padding(
              padding: textFieldPadding ??
                  const EdgeInsets.only(
                    top: AppDimensions.d12,
                    bottom: AppDimensions.d8,
                    right: AppDimensions.d12,
                    left: AppDimensions.d12,
                  ),
              child: TextField(
                onChanged: onChanged,
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                maxLength: maxLength,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                obscureText: obscure,
                controller: controller,
                style: const TextStyle(color: AppColors.daintree),
                decoration: InputDecoration(
                  labelStyle: context.tht.titleSmall,
                  suffixIcon: suffixIcon,
                  counterText: '',
                  errorText: error,
                  filled: true,
                  fillColor: AppColors.whiteSmoke,
                  hintText: hintText,
                  hintStyle: context.tht.titleSmall?.copyWith(
                    color: AppColors.manatee,
                  ),
                  errorStyle: TextStyle(
                    height: 0.8,
                    color: AppColors.red,
                    fontSize: error != '' ? AppDimensions.d12 : 0,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.red,
                      width: 1,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.daintree),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.daintree,
                      width: AppDimensions.d2,
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.daintree),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
