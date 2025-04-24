import 'package:flutter/material.dart';
import 'package:revival/features/Stock/presentation/views/show_stock.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart';
import 'package:revival/features/order/presentation/views/open_orders.dart';
import 'package:revival/features/business_partners/presentation/view/all_businesspartenars.dart';

import 'package:revival/core/theme/theme.dart';

final List<Color> _menuItemColors = [
  const Color(0xFFE0F2F1),
  const Color(0xFFE1F5FE),
  const Color(0xFFE8F5E9),
  const Color(0xFFF3E5F5),
  const Color(0xFFFFF3E0),
  const Color(0xFFE8EAF6),
];

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;

    final isTablet = screenWidth > 600;

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
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'Stock',
        'icon': Icons.inventory_2_outlined,
        'page': const WarehouseStockPage(),
      },
      {
        'title': 'Collect',
        'icon': Icons.payments_outlined,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'Reports',
        'icon': Icons.bar_chart_rounded,
        'page': const OpenOrdersScreen(),
      },
    ];

    final crossAxisCount = isTablet ? 3 : 2;

    final aspectRatio = isTablet ? 1.1 : 1.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: ResponsiveLayout(
            child: Column(
              children: [
                buildHeader(context, isTablet),
                buildBrandBar(context, 1.0, isTablet),

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

  Widget _buildWowMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isTablet,
    required Color backgroundColor,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final cardTheme = theme.cardTheme;

    final iconSize = isTablet ? 48.0 : 36.0;

    final splashColor = theme.splashColor;
    final highlightColor = theme.highlightColor;

    return Card(
      color: backgroundColor,

      elevation: cardTheme.elevation,
      shadowColor: cardTheme.shadowColor,
      shape: cardTheme.shape,

      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Container(
          padding: EdgeInsets.all(isTablet ? 20 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: colorScheme.primary, size: iconSize),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,

                style: (isTablet ? textTheme.titleMedium : textTheme.titleSmall)
                    ?.copyWith(color: darkTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context, bool isTablet) {
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
