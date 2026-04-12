import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/helper/extensions.dart';
import 'package:homz/core/routs/app_routs.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';
import 'package:homz/features/auth/widgets/signup_widgets/sign_up_header.dart';
import 'package:homz/features/auth/widgets/verification_widgets/otp_header_text.dart';
import 'package:homz/features/auth/widgets/verification_widgets/otp_input_row.dart';
import 'package:homz/features/auth/widgets/verification_widgets/resend_code_row.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  Locale? _lastLocale;

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
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

  // ─── Helpers ──────────────────────────────────────────────────────────────

  String get _otp => _controllers.map((c) => c.text).join();
  bool get _isOtpComplete => _otp.length == 4;

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _onCompleted() {
    if (_isOtpComplete) {
      FocusScope.of(context).unfocus();
      _onContinue();
    }
  }

  void _onContinue() {
    if (!_isOtpComplete) return;
    context.pushNamed(AppRoutes.createNewPasswordScreen);

    debugPrint('OTP entered: $_otp');
  }

  void _onResend() {
    // Clear all boxes and refocus first field
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();

    // Show beautiful snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.darker,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primaryLighter.withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryLighter.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  color: AppColors.primaryLighter,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'otp_resent_title'.tr(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'otp_resent_subtitle'.tr(),
                      style: TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                SignUpHeader(onBack: _onBack, titleKey: 'verification_code'),
                const Gap(32),
                OtpHeaderText(),
                const Gap(28),
                OtpInputRow(
                  controllers: _controllers,
                  focusNodes: _focusNodes,
                  onCompleted: _onCompleted,
                ),
                const Gap(28),
                AppButton(label: 'continue'.tr(), onTap: _onContinue),
                const Gap(20),
                ResendCodeRow(onResend: _onResend),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
