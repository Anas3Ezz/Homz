import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homz/core/theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<String> _iconPaths = [
    'assets/icons/home.svg',
    'assets/icons/search-normal.svg',
    'assets/icons/heart.svg',
    'assets/icons/message-2.svg',
    'assets/icons/profile.svg',
  ];

  static const List<String> _labelKeys = [
    'nav_home',
    'nav_search',
    'nav_wishlist',
    'nav_chat',
    'nav_profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.darkest,
        border: Border(
          top: BorderSide(color: AppColors.gray.withValues(alpha: 0.15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _iconPaths.length,
          (index) => _NavItem(
            iconPath: _iconPaths[index],
            labelKey: _labelKeys[index],
            isSelected: currentIndex == index,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String labelKey;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.labelKey,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLighter : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              // ✅ Programmatically change icon color based on selected state
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            // ✅ Label animates in/out smoothly when tab is selected
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Row(
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          labelKey.tr(),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
