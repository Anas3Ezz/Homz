import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';
import 'package:homz/core/widgets/app_button.dart';

class SuccessDialog extends StatefulWidget {
  final String titleKey;
  final String subtitleKey;
  final VoidCallback onContinue;

  const SuccessDialog({
    super.key,
    required this.titleKey,
    required this.subtitleKey,
    required this.onContinue,
  });

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // ✅ Start animation as soon as dialog appears
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          decoration: BoxDecoration(
            color: AppColors.darker,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.gray.withValues(alpha: 0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuccessIcon(),
              const SizedBox(height: 28),
              Text(
                widget.titleKey.tr(),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.subtitleKey.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.lightGray,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              AppButton(label: 'continue'.tr(), onTap: widget.onContinue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ✅ Outer glow ring
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(alpha: 0.08),
              ),
            ),
            // ✅ Floating dots — top left
            Positioned(top: 10, left: 16, child: _dot(6, AppColors.success)),
            // ✅ Floating dots — top right
            Positioned(
              top: 6,
              right: 20,
              child: _dot(5, AppColors.success.withValues(alpha: 0.6)),
            ),
            // ✅ Floating dots — bottom left
            Positioned(
              bottom: 14,
              left: 10,
              child: _dot(4, AppColors.success.withValues(alpha: 0.5)),
            ),
            // ✅ Floating dots — bottom right
            Positioned(
              bottom: 10,
              right: 14,
              child: _dot(7, AppColors.success.withValues(alpha: 0.7)),
            ),
            // ✅ Inner circle with check icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.success,
                size: 38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

/// ✅ Helper function to show the dialog cleanly from any screen
Future<void> showSuccessDialog({
  required BuildContext context,
  required String titleKey,
  required String subtitleKey,
  required VoidCallback onContinue,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.black.withValues(alpha: 0.85),
    builder: (_) => SuccessDialog(
      titleKey: titleKey,
      subtitleKey: subtitleKey,
      onContinue: onContinue,
    ),
  );
}
