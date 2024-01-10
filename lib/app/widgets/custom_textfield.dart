import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.error,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.textInputAction,
    this.leading,
    this.textFieldPadding,
    super.key,
    this.onChanged,
    this.hasPassword = false,
    this.prefix,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? error;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final Widget? leading;
  final EdgeInsets? textFieldPadding;
  final Function(String?)? onChanged;
  final bool hasPassword;
  final Widget? prefix;
  final bool autofocus;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = widget.hasPassword;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          widget.leading ?? const SizedBox.shrink(),
          Flexible(
            child: Padding(
              padding: widget.textFieldPadding ??
                  const EdgeInsets.only(
                    top: AppDimensions.d12,
                    bottom: AppDimensions.d8,
                    right: AppDimensions.d12,
                    left: AppDimensions.d12,
                  ),
              child: TextField(
                autofocus: widget.autofocus,
                onChanged: widget.onChanged,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                maxLength: widget.maxLength,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                obscureText: _obscurePassword,
                controller: widget.controller,
                style: const TextStyle(color: AppColors.daintree),
                decoration: InputDecoration(
                  prefix: widget.prefix,
                  suffixIcon: widget.hasPassword
                      ? IconButton(
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined),
                          color: AppColors.daintree,
                        )
                      : widget.suffixIcon,
                  counterText: '',
                  errorText: widget.error,
                  filled: true,
                  fillColor: AppColors.whiteSmoke,
                  hintText: widget.hintText,
                  hintStyle: context.tht.titleSmall?.copyWith(
                    color: AppColors.manatee,
                  ),
                  errorStyle: TextStyle(
                    height: 0.8,
                    color: AppColors.red,
                    fontSize: widget.error != '' ? AppDimensions.d12 : 0,
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
