import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/helper/extensions.dart';
import 'package:homz/core/helper/validators.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';
import 'package:homz/features/auth/widgets/password_field.dart';
import 'package:homz/features/auth/widgets/reset_password_hent_text.dart';
import 'package:homz/features/auth/widgets/signup_widgets/sign_up_header.dart';
import 'package:homz/features/auth/widgets/sucess_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Locale? _lastLocale;

  @override
  void dispose() {
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

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: pass new password to auth cubit/bloc
      debugPrint('New password: ${_passwordController.text.trim()}');
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showSuccessDialog(
      context: context,
      titleKey: 'reset_success_title',
      subtitleKey: 'reset_success_subtitle',
      onContinue: () {
        Navigator.pop(context); // Close dialog
        context.pushNamed(AppRoutes.login);
      },
    );
  }

  void _onBack() => Navigator.pop(context);

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
                  SignUpHeader(onBack: _onBack, titleKey: 'Reset Password'),
                  const Gap(32),
                  ResetPasswordHintText(),
                  const Gap(28),
                  PasswordField(
                    controller: _passwordController,
                    validator: AppValidators.password,
                  ),
                  const Gap(16),
                  PasswordField(
                    controller: _confirmPasswordController,
                    hintKey: 'confirm_password',
                    validator: (val) => AppValidators.confirmPassword(
                      val,
                      _passwordController.text,
                    ),
                  ),
                  const Gap(32),
                  AppButton(
                    label: 'reset_password'.tr(),
                    onTap: _onResetPassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
