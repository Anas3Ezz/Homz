import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:homz/core/theme/app_colors.dart';

import '../models/property_model.dart';
import '../widgets/category_tabs.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/property_carousel.dart';
import '../widgets/rent_buy_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRent = true;
  String _selectedCategory = 'residential';
  int _currentNavIndex = 0;

  // ✅ Static dummy data — replace with API data later
  final List<PropertyModel> _properties = [
    PropertyModel(
      id: '1',
      imageAsset: 'assets/images/Frame 14.png',
      title: 'Modern Living Room',
      location: 'Amman, Jordan',
      price: '\$1,200/mo',
      type: 'rent',
      category: 'residential',
    ),
    PropertyModel(
      id: '2',
      imageAsset: 'assets/images/Frame 14.png',
      title: 'Luxury Apartment',
      location: 'Dubai, UAE',
      price: '\$3,500/mo',
      type: 'rent',
      category: 'residential',
    ),
    PropertyModel(
      id: '3',
      imageAsset: 'assets/images/Frame 14.png',
      title: 'Office Space',
      location: 'Cairo, Egypt',
      price: '\$2,000/mo',
      type: 'rent',
      category: 'commercial',
    ),
  ];

  // ✅ Filter properties by selected toggle + category
  List<PropertyModel> get _filteredProperties => _properties.where((p) {
    final matchType = _isRent ? p.type == 'rent' : p.type == 'buy';
    final matchCategory = p.category == _selectedCategory;
    return matchType && matchCategory;
  }).toList();

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _onWishlistTap(PropertyModel property) {
    setState(() => property.isWishlisted = !property.isWishlisted);
  }

  void _onTakeLookTap(PropertyModel property) {
    // TODO: Navigate to property details screen
    debugPrint('Take a look at: ${property.title}');
  }

  void _onShareTap(PropertyModel property) {
    // TODO: Trigger share sheet
    debugPrint('Share: ${property.title}');
  }

  void _onNotificationTap() {
    // TODO: Navigate to notifications screen
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.black,
        bottomNavigationBar: HomeBottomNav(
          currentIndex: _currentNavIndex,
          onTap: (index) => setState(() => _currentNavIndex = index),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── App Bar ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: HomeAppBar(onNotificationTap: _onNotificationTap),
              ),
              const Gap(20),

              // ─── Rent / Buy Toggle ────────────────────────────────────────
              Center(
                child: RentBuyToggle(
                  isRent: _isRent,
                  onToggle: (val) => setState(() => _isRent = val),
                ),
              ),
              const Gap(24),

              // ─── Property Carousel ────────────────────────────────────────
              _filteredProperties.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          'No properties found',
                          style: TextStyle(color: AppColors.gray),
                        ),
                      ),
                    )
                  : PropertyCarousel(
                      properties: _filteredProperties,
                      onWishlistTap: _onWishlistTap,
                      onTakeLookTap: _onTakeLookTap,
                      onShareTap: _onShareTap,
                    ),
              const Gap(24),

              // ─── Category Tabs ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CategoryTabs(
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: (cat) =>
                      setState(() => _selectedCategory = cat),
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
