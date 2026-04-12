import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/helper/validators.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/features/auth/widgets/forget_password_hint_text.dart';
import 'package:homz/features/auth/widgets/plain_phone_field.dart';
import 'package:homz/features/auth/widgets/signup_widgets/sign_up_header.dart';

import '../../core/widgets/app_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  Locale? _lastLocale;

  @override
  void dispose() {
    _phoneController.dispose();
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

  void _onSendCode() {
    if (_formKey.currentState!.validate()) {
      // TODO: pass phone to auth cubit/bloc to send OTP
      debugPrint('Send code to: ${_phoneController.text.trim()}');
    }
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
                  SignUpHeader(onBack: _onBack, titleKey: 'forget_password'),
                  const Gap(32),
                  ForgetPasswordHintText(),
                  const Gap(24),
                  PlainPhoneField(
                    controller: _phoneController,
                    validator: AppValidators.phone,
                  ),
                  const Gap(28),
                  AppButton(label: 'send_code'.tr(), onTap: _onSendCode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
