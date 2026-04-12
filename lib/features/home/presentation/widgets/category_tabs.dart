import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class CategoryTabs extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  static const List<String> _categories = [
    'commercial',
    'residential',
    'shops',
  ];

  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _categories.map((category) {
        final isSelected = selectedCategory == category;
        return GestureDetector(
          onTap: () => onCategoryChanged(category),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.tr(),
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.gray,
                  fontSize: 15,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 6),
              // ✅ Animated underline indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}