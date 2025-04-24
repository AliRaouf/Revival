import 'package:flutter/material.dart';
import 'package:revival/features/Stock/presentation/views/show_stock.dart'; // Assuming path is correct
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart'; // Assuming uses theme
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart'; // Assuming uses theme
import 'package:revival/features/order/presentation/views/open_orders.dart';
import 'package:revival/features/business_partners/presentation/view/all_businesspartenars.dart'; // Assuming path is correct
// Import theme constants if needed (e.g., specific radii)
import 'package:revival/core/theme/theme.dart';

// Keep menu item specific colors here or in a separate constants file
// These are visual choices for the grid, not core theme elements
final List<Color> _menuItemColors = [
  const Color(0xFFE0F2F1), // Teal pale
  const Color(0xFFE1F5FE), // Light Blue pale
  const Color(0xFFE8F5E9), // Green pale
  const Color(0xFFF3E5F5), // Purple pale
  const Color(0xFFFFF3E0), // Orange pale
  const Color(0xFFE8EAF6), // Indigo pale
];

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    // textScaleFactor is automatically applied by Flutter's Text widgets
    // final textScale = mq.textScaleFactor;
    final isTablet = screenWidth > 600;

    // --- Menu Item Data (Structure remains the same) ---
    final menuItems = [
      {
        'title': 'Business Partner',
        'icon': Icons.people_alt_outlined,
        'page': const AllBusinessPartnerWowListPage(),
      },
      {
        'title': 'Orders',
        'icon': Icons.receipt_long_outlined,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'AR Invoice',
        'icon': Icons.request_quote_outlined,
        'page': const OpenOrdersScreen(), // Replace with actual page
      },
      {
        'title': 'Stock',
        'icon': Icons.inventory_2_outlined,
        'page': const WarehouseStockPage(),
      },
      {
        'title': 'Collect',
        'icon': Icons.payments_outlined,
        'page': const OpenOrdersScreen(), // Replace with actual page
      },
      {
        'title': 'Reports',
        'icon': Icons.bar_chart_rounded,
        'page': const OpenOrdersScreen(), // Replace with actual page
      },
    ];

    final crossAxisCount = isTablet ? 3 : 2;
    // Adjust aspect ratio for better spacing/sizing if needed
    final aspectRatio = isTablet ? 1.1 : 1.0;

    return Scaffold(
      // Use theme background color
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        // Use ResponsiveLayout if it handles theme/styling correctly
        child: Container(
          color: scaffoldBackgroundColor,
          child: ResponsiveLayout(
            child: Column(
              children: [
                // Assuming buildHeader and buildBrandBar use Theme.of(context)
                buildHeader(context, isTablet), // Pass isTablet if needed
                buildBrandBar(
                  context,
                  1.0,
                  isTablet,
                ), // Pass isTablet if needed

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(
                      20.0,
                    ), // Keep specific padding for grid
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 18.0, // Keep specific spacing
                      mainAxisSpacing: 18.0, // Keep specific spacing
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      final colorIndex = index % _menuItemColors.length;
                      final itemColor = _menuItemColors[colorIndex];

                      return _buildWowMenuItem(
                        context: context,
                        title: item['title'] as String,
                        icon: item['icon'] as IconData,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => item['page'] as Widget,
                              ),
                            ),
                        isTablet: isTablet,
                        backgroundColor: itemColor, // Pass the specific color
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Menu Item Builder ---
  Widget _buildWowMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isTablet,
    required Color backgroundColor, // Specific background color for this item
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Use theme's card properties for consistency, but allow background override
    final cardTheme = theme.cardTheme;
    // Use theme radius

    final iconSize = isTablet ? 48.0 : 36.0; // Keep specific icon size logic

    // Use theme splash/highlight or generate based on background
    final splashColor = theme.splashColor; // Default splash
    final highlightColor = theme.highlightColor; // Default highlight

    return Card(
      // Apply the specific background color passed in
      color: backgroundColor,
      // Use other properties from CardTheme
      elevation: cardTheme.elevation,
      shadowColor: cardTheme.shadowColor,
      shape: cardTheme.shape, // Use theme shape (includes border radius)
      // margin: cardTheme.margin, // Use theme margin
      child: InkWell(
        onTap: onTap, // Ensure InkWell matches card shape
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Container(
          // Padding inside the card
          padding: EdgeInsets.all(isTablet ? 20 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                // Use a consistent icon color, perhaps primary or onSurface
                color: colorScheme.primary,
                size: iconSize,
              ),
              const SizedBox(height: 12), // Keep specific spacing
              Text(
                title,
                textAlign: TextAlign.center,
                // Use theme text style, adjust size based on tablet/phone
                style: (isTablet ? textTheme.titleMedium : textTheme.titleSmall)
                    ?.copyWith(
                      // Ensure text color is readable on the varied backgrounds
                      color:
                          darkTextColor, // Use darkest text color for contrast
                    ),
                maxLines: 2, // Allow wrapping
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Placeholder Widgets (Replace with your actual implementations) ---
// Ensure these widgets also use Theme.of(context) for styling

Widget buildHeader(BuildContext context, bool isTablet) {
  // Example: Access theme properties
  final theme = Theme.of(context);
  return Container(
    height: 56,
    color: theme.colorScheme.primary,
    alignment: Alignment.center,
    child: Text(
      'Dashboard Header',
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onPrimary,
      ),
    ),
  );
}

// Assuming brand_bar.dart, dashboard_header.dart, layout_builder.dart
// are refactored to use Theme.of(context) internally.
