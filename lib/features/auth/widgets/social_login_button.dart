import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialLoginButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.darkest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray.withValues(alpha: 0.25)),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
