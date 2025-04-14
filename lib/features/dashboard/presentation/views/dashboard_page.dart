import 'package:flutter/material.dart';
import 'package:revival/features/order/presentation/views/open_orders.dart';


class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final textScale = mq.textScaleFactor;
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet ? screenWidth * 0.05 : 0.0;

    final menuItems = [
      {
        'title': 'Orders',
        'icon': Icons.list_alt_rounded,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'AR',
        'icon': Icons.archive_outlined,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'Stock',
        'icon': Icons.inventory_2_outlined,
        'page': const OpenOrdersScreen(),
      },
      {
        'title': 'Collect',
        'icon': Icons.monetization_on_outlined,
        'page': const OpenOrdersScreen(),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Container(
              color: const Color(0xFFF9FAFB),
              child: Column(
                children: [
                  _buildHeader(context, textScale, isTablet),
                  _buildBrandBar(context, textScale, isTablet),
                  const SizedBox(height: 8),
                  Expanded(
                    child:
                        isTablet
                            ? GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 3.5,
                              padding: const EdgeInsets.all(16),
                              children:
                                  menuItems.map((item) {
                                    return _buildMenuCard(
                                      context: context,
                                      title: item['title'] as String,
                                      icon: item['icon'] as IconData,
                                      onTap:
                                          () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => item['page'] as Widget,
                                            ),
                                          ),
                                      textScale: textScale,
                                      isTablet: isTablet,
                                    );
                                  }).toList(),
                            )
                            : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: menuItems.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemBuilder: (_, idx) {
                                final item = menuItems[idx];
                                return _buildMenuCard(
                                  context: context,
                                  title: item['title'] as String,
                                  icon: item['icon'] as IconData,
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => item['page'] as Widget,
                                        ),
                                      ),
                                  textScale: textScale,
                                  isTablet: isTablet,
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double textScale, bool isTablet) {
    final iconSize = isTablet ? 48.0 : 36.0;
    return Container(
      color: const Color(0xFF17405E),
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Username + code
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 17 * textScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Code of the sales person',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD1D5DB),
                  fontSize: 10.2 * textScale,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // Profile icon
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.26),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: iconSize * 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandBar(BuildContext context, double textScale, bool isTablet) {
    final barHeight = isTablet ? 72.0 : 56.0;
    return Container(
      width: double.infinity,
      height: barHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Image.network(
          'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
          width: MediaQuery.of(context).size.width * 0.45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required double textScale,
    required bool isTablet,
  }) {
    final iconContainerSize = isTablet ? 56.0 : 40.0;
    final iconSize = iconContainerSize * 0.5;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 20 : 16),
          child: Row(
            children: [
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: const BoxDecoration(
                  color: Color(0xFF17405E),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
              SizedBox(width: isTablet ? 24 : 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF1F2937),
                  fontSize: 15.3 * textScale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Your existing ResponsiveLayout remains unchanged
class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w > 1200) {
          return Center(child: SizedBox(width: 1200, child: child));
        } else if (w > 900) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.1),
            child: child,
          );
        } else if (w > 600) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: child,
          );
        } else {
          return child;
        }
      },
    );
  }
}
