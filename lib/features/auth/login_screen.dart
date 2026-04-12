import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/helper/extensions.dart';
import 'package:homz/core/helper/validators.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';
import 'package:homz/features/auth/widgets/login_widgets/login_header.dart';
import 'package:homz/features/auth/widgets/plain_phone_field.dart';

import 'widgets/login_widgets/dont_have_account_row.dart';
import 'widgets/login_widgets/forget_password_button.dart';
import 'widgets/login_widgets/skip_button.dart';
import 'widgets/or_continue_with_divider.dart';
import 'widgets/password_field.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _selectedDialCode = '+962';
  Locale? _lastLocale;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = context.locale;
    // Always update _lastLocale and trigger rebuild when locale changes
    if (_lastLocale != currentLocale) {
      _lastLocale = currentLocale;
      // Only call setState after the first frame to avoid build-phase errors
      if (WidgetsBinding.instance.lifecycleState != null) {
        setState(() {});
      }
    }
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _onSignIn() {
    if (_formKey.currentState!.validate()) {
      final fullPhone = '$_selectedDialCode${_phoneController.text.trim()}';
      debugPrint('Sign in with: $fullPhone');
    }
  }

  void _onForgotPassword() {
    context.pushNamed(AppRoutes.forgotPasswordScreen);
  }

  void _onSignUp() {
    context.pushNamed(AppRoutes.signup);
  }

  void _onGoogleLogin() {}
  void _onAppleLogin() {}
  void _onSkip() {
    context.pushNamed(AppRoutes.home);
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    LoginHeader(),
                    const Gap(56),
                    PlainPhoneField(
                      controller: _phoneController,
                      validator: AppValidators.phone,
                    ),
                    const Gap(16),
                    PasswordField(
                      controller: _passwordController,
                      validator: AppValidators.password,
                    ),
                    const Gap(12),
                    ForgotPasswordButton(onTap: _onForgotPassword),
                    const Gap(32),
                    AppButton(label: 'sign_in'.tr(), onTap: _onSignIn),
                    const Gap(24),
                    DontHaveAccountRow(onSignUpTap: _onSignUp),
                    const Gap(32),
                    const OrContinueWithDivider(),
                    const Gap(24),
                    Row(
                      children: [
                        SocialLoginButton(
                          onTap: _onGoogleLogin,
                          icon: Image.asset(
                            'assets/images/google.png',
                            height: 28,
                            width: 28,
                          ),
                        ),
                        const Gap(16),
                        SocialLoginButton(
                          onTap: _onAppleLogin,
                          icon: const Icon(
                            Icons.apple,
                            color: AppColors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
                    Center(child: SkipButton(onTap: _onSkip)),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
