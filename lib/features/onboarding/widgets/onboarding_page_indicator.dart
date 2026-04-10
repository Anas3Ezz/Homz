import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentIndex;

  const OnboardingPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: currentIndex == index ? 24 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentIndex == index ? AppColors.white : AppColors.gray,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
