import 'package:flutter/material.dart';

/// A simple row for the totals card with enhanced styling options.
class TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const TotalRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle ?? textTheme.bodyLarge),
        Text(value, style: valueStyle ?? textTheme.titleMedium),
      ],
    );
  }
}
