import 'package:flutter/material.dart';
import 'package:revival/shared/language_icon_button.dart';

Widget buildHeader(BuildContext context, double textScale, bool isTablet) {
  final iconSize = isTablet ? 52.0 : 40.0;
  return Container(
    color: Color(0xFF17405E),
    padding: EdgeInsets.symmetric(
      horizontal: isTablet ? 30 : 20,
      vertical: isTablet ? 20 : 15,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: (isTablet ? 19 : 17) * textScale,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Sales Person Code: 12345',
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
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: LanguageIconButton(),
        ),
      ],
    ),
  );
}
