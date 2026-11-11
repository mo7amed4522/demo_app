// File: lib/core/widgets/bx_create_as_lead_widget.dart
// Description: A widget that displays a lead creation form card with gradient background,
// includes name field, international phone selector (default UAE), specialty dropdown,
// and a gradient submit button.

// ignore_for_file: deprecated_member_use

import 'package:demo_app/core/constant/bx_app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';

class CountryPickerBottomSheet extends StatefulWidget {
  final Function(Country) onCountrySelected;
  final PhoneNumberController phoneController;

  const CountryPickerBottomSheet({
    super.key,
    required this.onCountrySelected,
    required this.phoneController,
  });

  @override
  State<CountryPickerBottomSheet> createState() =>
      _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = CountriesData.allCountries;
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = CountriesData.allCountries;
      } else {
        _filteredCountries = CountriesData.allCountries.where((country) {
          return country.name.toLowerCase().contains(query) ||
              country.dialCode.contains(query) ||
              country.code.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF415239),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select Country',
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: BxAppFonts.bxAppFonts,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                color: Colors.white,
                fontFamily: BxAppFonts.bxAppFonts,
              ),
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: 'Search country...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                          FocusScope.of(context).requestFocus();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _filteredCountries.length,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected =
                    country.code == widget.phoneController.selectedCountry.code;
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: Text(
                      country.flagEmoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(
                      country.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: BxAppFonts.bxAppFonts,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      country.dialCode,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      widget.onCountrySelected(country);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
