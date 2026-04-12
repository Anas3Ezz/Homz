import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class SignUpHeader extends StatelessWidget {
  final VoidCallback onBack;
  final String titleKey;

  const SignUpHeader({super.key, required this.onBack, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gray.withValues(alpha: 0.4)),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white,
              size: 16,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              titleKey.tr(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // Invisible spacer to keep title perfectly centered
        const SizedBox(width: 36),
      ],
    );
  }
}
