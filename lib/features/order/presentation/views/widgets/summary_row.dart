import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';

Widget buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodySmall),
          Text(
            value,
            style: (isBold
                    ? textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                    : textTheme.bodyMedium)
                ?.copyWith(color: darkTextColor),
          ),
        ],
      ),
    );
  }
