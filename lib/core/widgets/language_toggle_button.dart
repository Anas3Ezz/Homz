import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final bool isArabic = currentLocale.languageCode == 'ar';
    final label = isArabic ? 'lang_toggle_en'.tr() : 'lang_toggle_ar'.tr();
    final nextLocale = isArabic ? const Locale('en') : const Locale('ar');

    return GestureDetector(
      onTap: () async {
        await context.setLocale(nextLocale);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: .35),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.8)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
