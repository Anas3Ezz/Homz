import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

import 'presentation/widgets/language_toggle_button.dart';
import 'presentation/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      imageAsset: 'assets/images/onboarding_1.png',
      titleKey: 'onboarding_title_1',
      subtitleKey: 'onboarding_subtitle_1',
    ),
    _OnboardingPageData(
      imageAsset: 'assets/images/onboarding_2.png',
      titleKey: 'onboarding_title_2',
      subtitleKey: 'onboarding_subtitle_2',
    ),
    _OnboardingPageData(
      imageAsset: 'assets/images/onboarding_3.png',
      titleKey: 'onboarding_title_3',
      subtitleKey: 'onboarding_subtitle_3',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted() {
    // TODO: Navigate to the app's first authenticated or main screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                imageAsset: _pages[index].imageAsset,
                titleKey: _pages[index].titleKey,
                subtitleKey: _pages[index].subtitleKey,
                showNextButton: index < _pages.length - 1,
                onNext: index < _pages.length - 1
                    ? () => _goToPage(index + 1)
                    : null,
                showGetStartedButton: index == _pages.length - 1,
                onGetStarted: index == _pages.length - 1 ? _onGetStarted : null,
              );
            },
          ),
          const Positioned(top: 50, right: 16, child: LanguageToggleButton()),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentIndex == index ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.white
                        : AppColors.gray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final String imageAsset;
  final String titleKey;
  final String subtitleKey;

  const _OnboardingPageData({
    required this.imageAsset,
    required this.titleKey,
    required this.subtitleKey,
  });
}
