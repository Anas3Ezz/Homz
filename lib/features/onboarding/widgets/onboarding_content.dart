import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';

import 'onboarding_next_button.dart';

class OnboardingContent extends StatelessWidget {
  final String titleKey;
  final String subtitleKey;
  final bool showNextButton;
  final bool showGetStartedButton;
  final VoidCallback? onNext;
  final VoidCallback? onGetStarted;

  const OnboardingContent({
    super.key,
    required this.titleKey,
    required this.subtitleKey,
    this.showNextButton = false,
    this.showGetStartedButton = false,
    this.onNext,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleKey.tr(),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitleKey.tr(),
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.78),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              if (showGetStartedButton) ...[
                AppButton(label: 'get_started'.tr(), onTap: onGetStarted!),
                const Gap(16),
              ],
              if (showNextButton) OnboardingNextButton(onNext: onNext),
            ],
          ),
        ),
      ),
    );
  }
}
