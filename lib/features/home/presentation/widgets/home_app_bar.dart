import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onNotificationTap;

  const HomeAppBar({super.key, required this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Homz',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.gray.withValues(alpha: 0.4),
              ),
              color: AppColors.darkest,
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}