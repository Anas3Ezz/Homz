import 'package:flutter/material.dart';

import 'onboarding_background.dart';
import 'onboarding_content.dart';
import 'onboarding_gradient_overlay.dart';

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
        OnboardingBackground(imageAsset: imageAsset),
        const OnboardingGradientOverlay(),
        OnboardingContent(
          titleKey: titleKey,
          subtitleKey: subtitleKey,
          showNextButton: showNextButton,
          showGetStartedButton: showGetStartedButton,
          onNext: onNext,
          onGetStarted: onGetStarted,
        ),
      ],
    );
  }
}
