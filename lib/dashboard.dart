import 'package:flutter/material.dart';
import 'package:revival/orders.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveLayout(
          child: Column(
            children: [
              // Header section
              Container(
                color: const Color(0xFF17405E),
                child: Column(
                  children: [
                    // Top bar with username and icons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Username section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Code of the sales person',
                                style: TextStyle(
                                  color: const Color(0xFFD1D5DB),
                                  fontSize: 10.20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          // Action buttons
                          _buildIconButton(size: 36.0),
                        ],
                      ),
                    ),
                    // Brand bar
                    Container(
                      width: double.infinity,
                      height: 56,
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
                          width: MediaQuery.of(context).size.width * 0.45,
                          'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content section
              Expanded(
                child: Container(
                  color: const Color(0xFFF9FAFB),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        _buildMenuCard(
                          title: 'Orders',
                          icon: Icons.list_alt_rounded,
                          context: context,
                        ),
                        const SizedBox(height: 16),
                        _buildMenuCard(
                          title: 'AR',
                          icon: Icons.archive_outlined,
                          context: context,
                        ),
                        const SizedBox(height: 16),
                        _buildMenuCard(
                          title: 'Stock',
                          icon: Icons.inventory_2_outlined,
                          context: context,
                        ),
                        const SizedBox(height: 16),
                        _buildMenuCard(
                          title: 'Collect',
                          icon: Icons.monetization_on_outlined,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({double size = 28.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.26),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.white, size: size * 0.7),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required IconData icon,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrdersScreen()),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF17405E),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 15.3,
                  fontFamily: 'Inter',
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

// Responsive layout container that adapts to different screen sizes
class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the screen width
        final width = constraints.maxWidth;

        // For extra large screens, constrain the width with horizontal margins
        if (width > 1200) {
          return Center(child: SizedBox(width: 1200, child: child));
        }
        // For large screens
        else if (width > 900) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: child,
          );
        }
        // For medium screens
        else if (width > 600) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: child,
          );
        }
        // For small screens, use full width with small padding
        else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: child,
          );
        }
      },
    );
  }
}
