import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homz/core/theme/app_colors.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkest,
                border: Border.all(
                  color: AppColors.gray.withValues(alpha: 0.3),
                ),
              ),
              child: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 32,
                height: 32,
                colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'empty_state_title'.tr(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'empty_state_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
