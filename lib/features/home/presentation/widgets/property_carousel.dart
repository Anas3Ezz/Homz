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
        // ✅ First card peeks from left edge for visual depth
        padding: const EdgeInsets.only(left: 8),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return PropertyCard(
            property: property,
            onWishlistTap: () => onWishlistTap(property),
            onTakeLookTap: () => onTakeLookTap(property),
            onShareTap: () => onShareTap(property),
          );
        },
      ),
    );
  }
}