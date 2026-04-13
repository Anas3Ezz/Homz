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

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  // ignore: unused_field
  int _currentIndex = 0;

  // ✅ One AnimationController per page for FadeTransition
  // This replaces Opacity (expensive) + addListener setState (whole tree rebuild)
  late final List<AnimationController> _fadeControllers;
  late final List<Animation<double>> _fadeAnimations;

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
    // ✅ Create one controller per page
    _fadeControllers = List.generate(
      _pages.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        // ✅ First page starts fully visible, rest start faded out
        value: index == 0 ? 1.0 : 0.4,
      ),
    );
    _fadeAnimations = _fadeControllers
        .map(
          (c) => Tween<double>(
            begin: 0.4,
            end: 1.0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut)),
        )
        .toList();

    // ✅ AnimatedBuilder handles rebuilds surgically —
    // only the specific page widget rebuilds, not the whole screen
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    final page = _pageController.page ?? 0.0;
    for (int i = 0; i < _pages.length; i++) {
      final distance = (page - i).abs().clamp(0.0, 1.0);
      // ✅ Drive each controller directly from scroll position
      _fadeControllers[i].value = 1.0 - (distance * 0.6);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    for (final c in _fadeControllers) {
      c.dispose();
    }
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

        return AnimatedBuilder(
          // ✅ AnimatedBuilder only rebuilds THIS page's subtree
          // not the whole screen — surgical and efficient
          animation: _fadeControllers[index],
          builder: (context, child) {
            final value = _fadeAnimations[index].value;
            return Transform.scale(
              // ✅ Scale derived from fade value — no separate scroll listener
              scale: 0.92 + (value - 0.4) * (0.08 / 0.6),
              child: FadeTransition(
                // ✅ FadeTransition is GPU-accelerated — much cheaper than Opacity
                opacity: _fadeAnimations[index],
                child: child,
              ),
            );
          },
          child: OnboardingPage(
            imageAsset: page.imageAsset,
            titleKey: page.titleKey,
            subtitleKey: page.subtitleKey,
            showNextButton: !isLast,
            onNext: !isLast ? () => _goToPage(index + 1) : null,
            showGetStartedButton: isLast,
            onGetStarted: isLast ? _onGetStarted : null,
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
          effect: WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: AppColors.white,
            dotColor: AppColors.gray.withValues(alpha: 0.5),
            spacing: 12,
          ),
          onDotClicked: (index) => _goToPage(index),
        ),
      ),
    );
  }
}
