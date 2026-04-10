import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onTap;

  const SignInButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darker,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.gray.withValues(alpha: 0.25)),
          ),
          elevation: 0,
        ),
        child: Text(
          'sign_in'.tr(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
