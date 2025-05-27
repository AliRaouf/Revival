import 'package:flutter/material.dart';

Widget buildBrandBar(BuildContext context, double textScale, bool isTablet) {
    final barHeight = isTablet ? 72.0 : 56.0;
    return Material(
      elevation: 4.0, // Increased elevation
      shadowColor: Color(0x1A000000).withOpacity(0.5), // Customize shadow color
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: barHeight,
        // Removed explicit decoration, rely on Material
        child: Center(
          child: Image.network(
            'assets/images/image.png',
            height: barHeight * 0.5, // Control height relative to bar
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

 