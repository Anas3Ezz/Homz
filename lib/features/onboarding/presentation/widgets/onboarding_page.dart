import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String imageAsset;
  final String titleKey;
  final String subtitleKey;
  final bool showNextButton;
  final VoidCallback? onNext;
  final bool showGetStartedButton;
  final VoidCallback? onGetStarted;

  const OnboardingPage({
    super.key,
    required this.imageAsset,
    required this.titleKey,
    required this.subtitleKey,
    this.showNextButton = false,
    this.onNext,
    this.showGetStartedButton = false,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.black.withOpacity(0.8)],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
        Positioned.fill(
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
                      color: AppColors.white.withOpacity(0.78),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  if (showGetStartedButton)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLighter,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'get_started'.tr(),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  Gap(16),
                  if (showNextButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onNext,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white.withOpacity(0.8),
                              width: 1.5,
                            ),
                            color: AppColors.black.withOpacity(0.25),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
