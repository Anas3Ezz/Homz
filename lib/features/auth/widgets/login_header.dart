import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/language_toggle_button.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'welcome_to_homz'.tr(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const Spacer(),
        const LanguageToggleButton(),
      ],
    );
  }
}
