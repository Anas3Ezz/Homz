import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

import '../models/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onWishlistTap;
  final VoidCallback onTakeLookTap;
  final VoidCallback onShareTap;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onWishlistTap,
    required this.onTakeLookTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.82,
      height: 420,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(property.imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // ✅ Dark gradient overlay at bottom
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),

          // ✅ Wishlist heart button — top right
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: onWishlistTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black.withValues(alpha: 0.4),
                ),
                child: Icon(
                  property.isWishlisted
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: property.isWishlisted
                      ? AppColors.error
                      : AppColors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // ✅ Take a Look + Share buttons — bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: [
                // Take a Look button
                Expanded(
                  child: GestureDetector(
                    onTap: onTakeLookTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'take_a_look'.tr(),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Share button
                GestureDetector(
                  onTap: onShareTap,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLighter,
                    ),
                    child: const Icon(
                      Icons.reply_rounded,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}