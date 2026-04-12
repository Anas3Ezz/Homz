import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/helper/validators.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';
import 'package:homz/features/auth/widgets/or_continue_with_divider.dart';
import 'package:homz/features/auth/widgets/password_field.dart';
import 'package:homz/features/auth/widgets/plain_phone_field.dart';
import 'package:homz/features/auth/widgets/signup_widgets/name_field.dart';
import 'package:homz/features/auth/widgets/signup_widgets/sign_up_header.dart';
import 'package:homz/features/auth/widgets/social_login_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final String _selectedDialCode = '+962';
  Locale? _lastLocale;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentLocale = context.locale;
    if (_lastLocale != currentLocale) {
      _lastLocale = currentLocale;
      if (WidgetsBinding.instance.lifecycleState != null) {
        setState(() {});
      }
    }
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      final fullPhone = '$_selectedDialCode${_phoneController.text.trim()}';
      // TODO: pass to auth cubit/bloc
      debugPrint('Sign up — name: ${_nameController.text.trim()}');
      debugPrint('Sign up — phone: $fullPhone');
    }
  }

  void _onBack() => Navigator.pop(context);
  void _onGoogleSignUp() {} // TODO: Trigger Google sign up
  void _onAppleSignUp() {} // TODO: Trigger Apple sign up

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  SignUpHeader(onBack: _onBack, titleKey: 'create_account'),
                  const Gap(40),
                  NameField(
                    controller: _nameController,
                    validator: AppValidators.name,
                  ),
                  const Gap(16),
                  PlainPhoneField(
                    controller: _phoneController,
                    validator: AppValidators.phone,
                  ),
                  const Gap(16),
                  PasswordField(
                    controller: _passwordController,
                    validator: AppValidators.password,
                  ),
                  const Gap(16),
                  //  Confirm password uses confirmPassword validator
                  // passing the live value of _passwordController
                  PasswordField(
                    controller: _confirmPasswordController,
                    hintKey: 'confirm_password',
                    validator: (val) => AppValidators.confirmPassword(
                      val,
                      _passwordController.text,
                    ),
                  ),
                  const Gap(32),
                  AppButton(label: 'sign_up'.tr(), onTap: _onSignUp),
                  const Gap(32),
                  const OrContinueWithDivider(),
                  const Gap(24),
                  Row(
                    children: [
                      SocialLoginButton(
                        onTap: _onGoogleSignUp,
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 28,
                          width: 28,
                        ),
                      ),
                      const Gap(16),
                      SocialLoginButton(
                        onTap: _onAppleSignUp,
                        icon: const Icon(
                          Icons.apple,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
