import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homz/core/helper/extensions.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/language_toggle_button.dart';
import 'package:homz/features/onboarding/widgets/onboarding_page.dart';
import 'package:homz/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  double _currentPageValue = 0.0;

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

  static const _animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _currentPageValue = _pageController.page ?? 0.0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: _animationDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  void _onGetStarted() {
    context.pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            _buildPageView(),
            const Positioned(top: 50, right: 16, child: LanguageToggleButton()),
            _buildPageIndicator(),
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
        final distance = (_currentPageValue - index).abs();
        final opacity = (1.0 - (distance * 0.6)).clamp(0.4, 1.0);
        final scale = (1.0 - (distance * 0.08)).clamp(0.92, 1.0);

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: OnboardingPage(
              imageAsset: page.imageAsset,
              titleKey: page.titleKey,
              subtitleKey: page.subtitleKey,
              showNextButton: !isLast,
              onNext: !isLast ? () => _goToPage(index + 1) : null,
              showGetStartedButton: isLast,
              onGetStarted: isLast ? _onGetStarted : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          count: _pages.length,
          // ✅ WormEffect matches the expanding dot style we had before
          // but with much smoother animation
          effect: WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: AppColors.white,
            dotColor: AppColors.gray.withValues(alpha: 0.5),
            spacing: 12,
          ),
          // ✅ Tapping a dot navigates directly to that page
          onDotClicked: (index) => _goToPage(index),
        ),
      ),
    );
  }
}
