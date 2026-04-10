import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/features/auth/widgets/login_header.dart';

import 'widgets/dont_have_account_row.dart';
import 'widgets/forget_password_button.dart';
import 'widgets/or_continue_with_divider.dart';
import 'widgets/password_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/sign_in_button.dart';
import 'widgets/skip_button.dart';
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
  String _selectedDialCode = '+962';

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ─── Validators ───────────────────────────────────────────────────────────

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_phone_required'.tr();
    }
    if (!RegExp(r'^\d{7,15}$').hasMatch(value.trim())) {
      return 'error_phone_invalid'.tr();
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_password_required'.tr();
    }
    if (value.trim().length < 8) {
      return 'error_password_min_length'.tr();
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'error_password_uppercase'.tr();
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'error_password_number'.tr();
    }
    return null;
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _onSignIn() {
    if (_formKey.currentState!.validate()) {
      final fullPhone = '$_selectedDialCode${_phoneController.text.trim()}';
      debugPrint('Sign in with: $fullPhone');
    }
  }

  void _onForgotPassword() {}
  void _onSignUp() {}
  void _onGoogleLogin() {}
  void _onAppleLogin() {}
  void _onSkip() {}

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
        // ✅ Use SizedBox with screen height to spread content like the design
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
                    const LoginHeader(),
                    const Gap(56),
                    PhoneField(
                      controller: _phoneController,
                      onCountryChanged: (dialCode) =>
                          setState(() => _selectedDialCode = dialCode),
                      validator: _phoneValidator,
                    ),
                    const Gap(16),
                    PasswordField(
                      controller: _passwordController,
                      validator: _passwordValidator,
                    ),
                    const Gap(12),
                    ForgotPasswordButton(onTap: _onForgotPassword),
                    const Gap(32),
                    SignInButton(onTap: _onSignIn),
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
