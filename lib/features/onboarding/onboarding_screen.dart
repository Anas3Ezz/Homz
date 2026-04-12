import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homz/core/helper/extensions.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/core/widgets/language_toggle_button.dart';
import 'package:homz/features/onboarding/widgets/onboarding_page.dart';
import 'package:homz/features/onboarding/widgets/onboarding_page_data.dart';
import 'package:homz/features/onboarding/widgets/onboarding_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  // Future<void> _precacheImages() async {
  //   for (final page in _pages) {
  //     await precacheImage(AssetImage(page.imageAsset), context);
  //   }
  // }
  Future<void> _precacheImages() async {
    await Future.wait([
      for (final page in _pages)
        precacheImage(AssetImage(page.imageAsset), context),
    ]);
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
      curve: Curves.easeInOut,
    );
  }

  void _onGetStarted() {
    context.pushNamed(AppRoutes.login);
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
