import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class ResendCodeRow extends StatelessWidget {
  final VoidCallback onResend;

  const ResendCodeRow({super.key, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'otp_resend_hint'.tr(),
          style: TextStyle(color: AppColors.lightGray, fontSize: 14),
        ),
        GestureDetector(
          onTap: onResend,
          child: Text(
            'otp_resend'.tr(),
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
