class PropertyModel {
  final String id;
  final String imageAsset;
  final String title;
  final String location;
  final String price;
  final String type; // 'rent' or 'buy'
  final String category; // 'commercial', 'residential', 'shops'
  bool isWishlisted;

  PropertyModel({
    required this.id,
    required this.imageAsset,
    required this.title,
    required this.location,
    required this.price,
    required this.type,
    required this.category,
    this.isWishlisted = false,
  });
}