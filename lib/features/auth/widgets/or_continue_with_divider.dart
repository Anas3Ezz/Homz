import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class OrContinueWithDivider extends StatelessWidget {
  const OrContinueWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.gray.withValues(alpha: 0.4),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or_continue_with'.tr(),
            style: TextStyle(color: AppColors.lightGray, fontSize: 13),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.gray.withValues(alpha: 0.4),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
