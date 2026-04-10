import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homz/features/onboarding/presentation/widgets/language_toggle_button.dart';
import 'package:homz/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:homz/features/onboarding/presentation/widgets/onboarding_page_data.dart';
import 'package:homz/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  static const List<OnboardingPageData> _pages = [
    OnboardingPageData(
      imageAsset: 'assets/images/onboarding_1.png',
      titleKey: 'onboarding_title_1',
      subtitleKey: 'onboarding_subtitle_1',
    ),
    OnboardingPageData(
      imageAsset: 'assets/images/onboarding_2.png',
      titleKey: 'onboarding_title_2',
      subtitleKey: 'onboarding_subtitle_2',
    ),
    OnboardingPageData(
      imageAsset: 'assets/images/onboarding_3.png',
      titleKey: 'onboarding_title_3',
      subtitleKey: 'onboarding_subtitle_3',
    ),
  ];

  static const _animationDuration = Duration(milliseconds: 400);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted() {
    // TODO: Navigate to the main screen
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // white icons (Android)
        statusBarBrightness: Brightness.dark, // white icons (iOS)
      ),
      child: Scaffold(
        body: Stack(
          children: [
            _buildPageView(),
            const Positioned(top: 50, right: 16, child: LanguageToggleButton()),
            OnboardingPageIndicator(
              pageCount: _pages.length,
              currentIndex: _currentIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (index) => setState(() => _currentIndex = index),
      itemBuilder: (context, index) {
        final page = _pages[index];
        final isLast = index == _pages.length - 1;
        return OnboardingPage(
          imageAsset: page.imageAsset,
          titleKey: page.titleKey,
          subtitleKey: page.subtitleKey,
          showNextButton: !isLast,
          onNext: !isLast ? () => _goToPage(index + 1) : null,
          showGetStartedButton: isLast,
          onGetStarted: isLast ? _onGetStarted : null,
        );
      },
    );
  }
}
