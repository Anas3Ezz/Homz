import 'package:flutter/material.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/features/auth/forget_password_screen.dart';
import 'package:homz/features/auth/login_screen.dart';
import 'package:homz/features/auth/reset_password_screen.dart';
import 'package:homz/features/auth/sign_up_screen.dart';
import 'package:homz/features/auth/verification_code_screen.dart';
import 'package:homz/features/home/presentation/screens/home_screen.dart';
import 'package:homz/features/onboarding/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case AppRoutes.otpVerfication:
        return MaterialPageRoute(
          builder: (_) => const VerificationCodeScreen(),
        );
      case AppRoutes.createNewPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
