import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          // ✅ Defaults to primaryLighter, pass any color to override
          backgroundColor: backgroundColor ?? AppColors.primaryLighter,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            side: backgroundColor == AppColors.darker
                ? BorderSide(color: AppColors.gray.withValues(alpha: 0.25))
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            // ✅ Defaults to white, pass any color to override
            color: textColor ?? AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
