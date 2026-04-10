import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback? onNext;

  const OnboardingNextButton({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onNext,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
            color: AppColors.black.withValues(alpha: 0.25),
          ),
          child: const Icon(Icons.arrow_forward, color: AppColors.white),
        ),
      ),
    );
  }
}
