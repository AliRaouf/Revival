  import 'package:flutter/material.dart';

Widget buildLabeledField(
      BuildContext context, {
        required String label,
        required double textScale,
        bool obscureText = false,
        Widget? suffix,
        TextEditingController? controller,
        TextInputType? keyboardType,
      }) {
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: const Color(0xFF374151),
      fontSize: 12.8 * textScale, // Slightly larger label
      fontWeight: FontWeight.w600, // More prominent label
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6), // Slightly larger spacing
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, // More horizontal padding
              vertical: 15, // More vertical padding
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // More rounded border
              borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1.2), // Slightly thicker border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1.2),
            ),
            focusedBorder: OutlineInputBorder( // Highlight on focus
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            suffixIcon: suffix != null
                ? SizedBox(
              width: 56, // Larger width for icon area
              height: 56,
              child: Center(child: suffix),
            )
                : null,
          ),
        ),
      ],
    );
  }