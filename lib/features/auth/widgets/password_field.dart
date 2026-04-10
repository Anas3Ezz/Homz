import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      style: const TextStyle(color: AppColors.white),
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: 'password'.tr(),
        hintStyle: TextStyle(color: AppColors.lightGray),
        filled: true,
        fillColor: AppColors.darkest,
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.lightGray),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscure = !_obscure),
          child: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.lightGray,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLighter),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
