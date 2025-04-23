import 'package:flutter/material.dart';

Widget buildBrandBar(BuildContext context, double textScale, bool isTablet) {
    // ... (Brand bar code remains the same)
    final barHeight = isTablet ? 72.0 : 56.0;
    return Material(
      // Use Material for elevation control
      elevation: 4.0, // Increased elevation
      shadowColor: Color(0x1A000000).withOpacity(0.5), // Customize shadow color
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: barHeight,
        // Removed explicit decoration, rely on Material
        child: Center(
          child: Image.network(
            'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
            height: barHeight * 0.5, // Control height relative to bar
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

 