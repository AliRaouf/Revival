import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';

/// A reusable card widget to display information sections.
/// It uses the app's CardTheme for styling.
class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const InfoCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
          side: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 1,
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(18.0),
          child: child,
        ),
      ),
    );
  }
}
