import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // ... (ResponsiveLayout code remains the same)
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        // Adjusted breakpoints slightly
        if (w > 1100) {
          // Max width for very large screens
          return Center(child: SizedBox(width: 1100, child: child));
        } else if (w > 800) {
          // Large tablets/small desktops
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.1), // Side margins
            child: child,
          );
        } else if (w > 600) {
          // Tablets
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
            ), // Smaller side margins
            child: child,
          );
        } else {
          // Mobile
          return child; // No horizontal padding, handled by GridView padding
        }
      },
    );
  }
}