import 'package:flutter/material.dart';

import '../models/property_model.dart';
import 'property_card.dart';

class PropertyCarousel extends StatelessWidget {
  final List<PropertyModel> properties;
  final Function(PropertyModel) onWishlistTap;
  final Function(PropertyModel) onTakeLookTap;
  final Function(PropertyModel) onShareTap;

  const PropertyCarousel({
    super.key,
    required this.properties,
    required this.onWishlistTap,
    required this.onTakeLookTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 8),
        // ✅ addAutomaticKeepAlives false — cards not visible are not kept
        // alive in memory, reducing RAM usage in long lists
        addAutomaticKeepAlives: false,
        // ✅ addRepaintBoundaries true (default) — each card gets its own
        // repaint layer so scrolling one card doesn't repaint others
        addRepaintBoundaries: true,
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          final isLast = index == properties.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 24 : 16),
            child: PropertyCard(
              property: property,
              onWishlistTap: () => onWishlistTap(property),
              onTakeLookTap: () => onTakeLookTap(property),
              onShareTap: () => onShareTap(property),
            ),
          );
        },
      ),
    );
  }
}
