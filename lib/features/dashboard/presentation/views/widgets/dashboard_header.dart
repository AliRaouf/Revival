import 'package:flutter/material.dart';

Widget buildHeader(BuildContext context, double textScale, bool isTablet) {
    // ... (Header code remains the same)
    final iconSize = isTablet ? 52.0 : 40.0; // Slightly larger icon
    return Container(
      color: Color(0xFF17405E),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 30 : 20,
        vertical: isTablet ? 20 : 15,
      ), // More padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username', // Replace with actual username
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (isTablet ? 19 : 17) * textScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Sales Person Code: 12345', // Example code
                style: TextStyle(
                  color: Color(0xFFD1D5DB),
                  fontSize: (isTablet ? 12 : 10.2) * textScale,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Slightly lighter opacity
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline, // Outline icon
              color: Colors.white,
              size: iconSize * 0.55,
            ),
          ),
        ],
      ),
    );
  }

