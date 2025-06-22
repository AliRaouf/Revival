import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

// ignore: must_be_immutable
class BusinessPartnerAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  String selectedPartnerType;
  final TextEditingController searchController;
  final bool isSearching;
  final List<DropdownMenuItem<String>> partnerTypeOptions;
  final Function filterPartners;
  BusinessPartnerAppbar({
    super.key,
    required this.selectedPartnerType,
    required this.searchController,
    required this.isSearching,
    required this.partnerTypeOptions,
    required this.filterPartners,
  });

  @override
  State<BusinessPartnerAppbar> createState() => _BusinessPartnerAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(160);
}

class _BusinessPartnerAppbarState extends State<BusinessPartnerAppbar> {
  @override
  Widget build(BuildContext context) {
    Utilities utilities = Utilities(context);
    return AppBar(
      title: Text("Business Partners")
          .animate()
          .fadeIn(duration: 400.ms)
          .slideY(begin: -0.2, duration: 300.ms, curve: Curves.easeOut),
      backgroundColor: utilities.colorScheme.primary,
      foregroundColor: utilities.colorScheme.onPrimary,
      elevation: 2.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          color: utilities.colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              TextField(
                controller: widget.searchController,
                style: utilities.textTheme.bodyMedium?.copyWith(
                  color: utilities.colorScheme.primary,
                ),
                cursorColor: utilities.colorScheme.primary.withOpacity(0.7),
                decoration: InputDecoration(
                  hintText: 'Search Name or Code',
                  hintStyle: utilities.textTheme.bodyMedium?.copyWith(
                    color: utilities.colorScheme.primary.withOpacity(0.7),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: utilities.colorScheme.primary.withOpacity(0.8),
                    size: 20,
                  ),
                  filled: true,
                  // Use a slightly darker shade of primary for search bar background
                  fillColor: cardBackgroundColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon:
                      widget.isSearching
                          ? IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.clear,
                              color: utilities.colorScheme.onPrimary
                                  .withOpacity(0.8),
                              size: 20,
                            ),
                            onPressed: () => widget.searchController.clear(),
                          )
                          : null,
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

              const SizedBox(height: 10),

              SizedBox(
                height: 30,
                child: DropdownButtonFormField<String>(
                  value: widget.selectedPartnerType,
                  isExpanded: true,
                  items: widget.partnerTypeOptions,
                  onChanged: (String? newValue) {
                    if (newValue == null ||
                        newValue == widget.selectedPartnerType) {
                      return;
                    }
                    setState(() {
                      widget.selectedPartnerType = newValue;
                      widget.filterPartners();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: utilities.colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      // Use utilities's accent color (secondary or primary) for focused border
                      borderSide: BorderSide(
                        color:
                            utilities
                                .colorScheme
                                .secondary, // Or utilities.colorScheme.primary
                        width: 1.5,
                      ),
                    ),
                  ),
                  // Use utilities's onSurface color for dropdown text
                  style: utilities.textTheme.bodyMedium?.copyWith(
                    color: utilities.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    // Use utilities's primary color for the icon
                    color: utilities.colorScheme.primary,
                    size: 20,
                  ),
                  // Use utilities's surface color for dropdown menu background
                  dropdownColor: utilities.colorScheme.surface,
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
