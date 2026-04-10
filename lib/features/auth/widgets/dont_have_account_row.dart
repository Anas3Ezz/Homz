import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class DontHaveAccountRow extends StatelessWidget {
  final VoidCallback onSignUpTap;

  const DontHaveAccountRow({super.key, required this.onSignUpTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'dont_have_account'.tr(),
          style: TextStyle(color: AppColors.lightGray, fontSize: 14),
        ),
        GestureDetector(
          onTap: onSignUpTap,
          child: Text(
            'sign_up'.tr(),
            style: const TextStyle(
              color: AppColors.primaryLighter,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
