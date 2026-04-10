import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onCountryChanged;
  final String? Function(String?) validator;

  const PhoneField({
    super.key,
    required this.controller,
    required this.onCountryChanged,
    required this.validator,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String _selectedDialCode = '+962';

  // Most commonly used countries — extend as needed
  static const List<Map<String, String>> _countries = [
    {'name': 'Jordan', 'dialCode': '+962'},
    {'name': 'Saudi Arabia', 'dialCode': '+966'},
    {'name': 'United Arab Emirates', 'dialCode': '+971'},
    {'name': 'Egypt', 'dialCode': '+20'},
    {'name': 'Kuwait', 'dialCode': '+965'},
    {'name': 'Qatar', 'dialCode': '+974'},
    {'name': 'Bahrain', 'dialCode': '+973'},
    {'name': 'Oman', 'dialCode': '+968'},
    {'name': 'Lebanon', 'dialCode': '+961'},
    {'name': 'Iraq', 'dialCode': '+964'},
    {'name': 'Syria', 'dialCode': '+963'},
    {'name': 'Palestine', 'dialCode': '+970'},
    {'name': 'United States', 'dialCode': '+1'},
    {'name': 'United Kingdom', 'dialCode': '+44'},
    {'name': 'Germany', 'dialCode': '+49'},
    {'name': 'France', 'dialCode': '+33'},
    {'name': 'Turkey', 'dialCode': '+90'},
  ];

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darker,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CountryPickerSheet(
        countries: _countries,
        selectedDialCode: _selectedDialCode,
        onSelected: (dialCode) {
          setState(() => _selectedDialCode = dialCode);
          widget.onCountryChanged(dialCode);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: AppColors.white),
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: 'mobile_number'.tr(),
        hintStyle: TextStyle(color: AppColors.lightGray),
        filled: true,
        fillColor: AppColors.darkest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gray.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryLighter),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        prefixIcon: GestureDetector(
          onTap: _showCountryPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedDialCode,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.lightGray,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final List<Map<String, String>> countries;
  final String selectedDialCode;
  final ValueChanged<String> onSelected;

  const _CountryPickerSheet({
    required this.countries,
    required this.selectedDialCode,
    required this.onSelected,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late List<Map<String, String>> _filtered;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.countries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filtered = widget.countries
          .where(
            (c) =>
                c['name']!.toLowerCase().contains(query.toLowerCase()) ||
                c['dialCode']!.contains(query),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            onChanged: _onSearch,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'search'.tr(),
              hintStyle: TextStyle(color: AppColors.lightGray),
              prefixIcon: Icon(Icons.search, color: AppColors.lightGray),
              filled: true,
              fillColor: AppColors.dark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (_, index) {
                final country = _filtered[index];
                final isSelected =
                    country['dialCode'] == widget.selectedDialCode;
                return ListTile(
                  onTap: () {
                    widget.onSelected(country['dialCode']!);
                    Navigator.pop(context);
                  },
                  title: Text(
                    country['name']!,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primaryLighter
                          : AppColors.white,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    country['dialCode']!,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primaryLighter
                          : AppColors.lightGray,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
