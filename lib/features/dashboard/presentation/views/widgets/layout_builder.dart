import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;

        if (w > 1100) {
          return Center(child: SizedBox(width: 1100, child: child));
        } else if (w > 800) {
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
