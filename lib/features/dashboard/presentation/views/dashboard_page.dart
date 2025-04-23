import 'package:flutter/material.dart';
import 'package:revival/features/Stock/presentation/views/show_stock.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart';
import 'package:revival/features/order/presentation/views/open_orders.dart';
import 'package:revival/features/business_partners/presentation/view/all_businesspartenars.dart'; // Make sure path is correct

const Color darkTextColor = Color(0xFF1F2937);
final List<Color> menuItemColors = [
  Color(0xFFE0F2F1), // Teal pale
  Color(0xFFE1F5FE), // Light Blue pale
  Color(0xFFE8F5E9), // Green pale
  Color(0xFFF3E5F5), // Purple pale
  Color(0xFFFFF3E0), // Orange pale
  Color(0xFFE8EAF6), // Indigo pale
];

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final textScale = mq.textScaleFactor;
    final isTablet = screenWidth > 600;

    final menuItems = [
      {
        'title': 'Business Partner',
        'icon': Icons.people_alt_outlined,
        'page':
            const AllBusinessPartnerWowListPage(), // Ensure this class name matches your file
      },
      {
        'title': 'Orders',
        'icon': Icons.receipt_long_outlined,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'AR Invoice',
        'icon': Icons.request_quote_outlined,
        'page': const OpenOrdersScreen(), // Replace
      },
      {
        'title': 'Stock',
        'icon': Icons.inventory_2_outlined,
        'page':
            const WarehouseStockPage(), // Ensure this class name matches your file
      },
      {
        'title': 'Collect',
        'icon': Icons.payments_outlined,
        'page': const OpenOrdersScreen(), // Replace
      },
      {
        'title': 'Reports',
        'icon': Icons.bar_chart_rounded,
        'page': const OpenOrdersScreen(), // Replace
      },
    ];

    final crossAxisCount = isTablet ? 3 : 2;
    final aspectRatio = isTablet ? 1.1 : 1.0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF9FAFB),
          child: ResponsiveLayout(
            child: Column(
              children: [
                buildHeader(context, textScale, isTablet),
                buildBrandBar(context, textScale, isTablet),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 18.0,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      // --- Calculate Color Index ---
                      final colorIndex = index % menuItemColors.length;
                      final itemColor = menuItemColors[colorIndex];

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
                        textScale: textScale,
                        isTablet: isTablet,
                        // --- Pass the selected color ---
                        backgroundColor: itemColor,
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

  // --- UPDATED "WOW" Menu Item Builder ---
  Widget _buildWowMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required double textScale,
    required bool isTablet,
    required Color backgroundColor, // Added background color parameter
  }) {
    final iconSize = isTablet ? 48.0 : 36.0;
    final borderRadius = BorderRadius.circular(12.0);

    // Generate splash/highlight colors based on the background
    final splashColor = Colors.black.withOpacity(
      0.08,
    ); // Consistent subtle dark splash
    final highlightColor = Colors.black.withOpacity(
      0.04,
    ); // Consistent subtle dark highlight

    return Material(
      // --- Apply the background color ---
      color: backgroundColor,
      borderRadius: borderRadius,
      elevation: 5.0,
      shadowColor: Color(0x1A000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: splashColor, // Use generated splash
        highlightColor: highlightColor, // Use generated highlight
        child: Container(
          padding: EdgeInsets.all(isTablet ? 20 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                // --- Keep icon color consistent for visibility ---
                color: Color(0xFF17405E),
                size: iconSize,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                // --- Keep text color consistent for visibility ---
                style: TextStyle(
                  color: darkTextColor,
                  fontSize: (isTablet ? 16 : 14) * textScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Responsive Layout (Unchanged) ---
