import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class ResetPasswordHintText extends StatelessWidget {
  const ResetPasswordHintText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'reset_password_title'.tr(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'reset_password_subtitle'.tr(),
          style: TextStyle(
            color: AppColors.lightGray,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
