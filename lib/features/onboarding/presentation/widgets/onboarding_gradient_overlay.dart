import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class OnboardingGradientOverlay extends StatelessWidget {
  const OnboardingGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.black.withValues(alpha: 0.8),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
