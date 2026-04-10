import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'forget_password'.tr(),
          style: const TextStyle(
            color: AppColors.primaryLighter,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
