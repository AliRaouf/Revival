import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';

/// A reusable row widget to display a label and a value.
/// It uses text styles from the app's TextTheme.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isValueBold;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isValueBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          // Uses labelSmall from the appTheme for labels
          style: textTheme.labelSmall?.copyWith(color: mediumTextColor),
        ),
        const SizedBox(height: 5),
        Text(
          value.isEmpty ? '-' : value,
          // Uses titleMedium for prominent values and bodyMedium for regular ones
          style: (isValueBold ? textTheme.titleMedium : textTheme.bodyMedium)
              ?.copyWith(height: 1.3),
        ),
      ],
    );
  }
}
