import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

class PasswordTextFieldWidget extends HookWidget {
  const PasswordTextFieldWidget({
    required this.controller,
    required this.hintText,
    this.error,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    required this.obscurePassword,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final String? error;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final ValueNotifier<bool> obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.d12,
        bottom: AppDimensions.d8,
        right: AppDimensions.d12,
        left: AppDimensions.d12,
      ),
      child: TextField(
        textCapitalization: textCapitalization,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscurePassword.value,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => obscurePassword.value
                ? obscurePassword.value = false
                : obscurePassword.value = true,
            child: Icon(
              obscurePassword.value ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
              color: AppColors.daintree,
            ),
          ),
          labelText: hintText,
          labelStyle: context.tht.titleSmall,
          counterText: '',
          errorText: error,
          filled: true,
          fillColor: AppColors.whiteSmoke,
          hintText: hintText,
          hintStyle: context.tht.titleSmall?.copyWith(
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
            borderSide: BorderSide(color: AppColors.daintree),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.daintree,
              width: AppDimensions.d2,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.daintree),
          ),
        ),
      ),
    );
  }
}
