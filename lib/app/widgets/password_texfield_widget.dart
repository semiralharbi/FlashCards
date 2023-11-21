import 'package:flutter/services.dart';

import '../theme/global_imports.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    required this.controller,
    required this.hintText,
    this.error,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.obscurePassword = true,
    super.key,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? error;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final bool obscurePassword;

  @override
  State<PasswordTextFieldWidget> createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = widget.obscurePassword;
  }

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
        textCapitalization: widget.textCapitalization,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        obscureText: _obscurePassword,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscurePassword = !_obscurePassword),
            child: Icon(
              _obscurePassword ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
              color: AppColors.daintree,
            ),
          ),
          labelText: widget.hintText,
          labelStyle: context.tht.titleSmall,
          counterText: '',
          errorText: widget.error,
          filled: true,
          fillColor: AppColors.whiteSmoke,
          hintText: widget.hintText,
          hintStyle: context.tht.titleSmall?.copyWith(
            color: AppColors.manatee,
          ),
          errorStyle: TextStyle(
            height: 1,
            color: AppColors.red,
            fontSize: widget.error != '' ? AppDimensions.d14 : 0,
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
