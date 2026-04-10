import 'package:flutter/material.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/features/auth/login_screen.dart';
import 'package:homz/features/onboarding/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
