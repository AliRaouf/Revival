import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';

/// A reusable card widget to display information sections.
/// It uses the app's CardTheme for styling with enhanced professional appearance.
class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final String? title;
  final IconData? titleIcon;
  final Color? backgroundColor;
  final bool showBorder;

  const InfoCard({
    super.key,
    required this.child,
    this.padding,
    this.title,
    this.titleIcon,
    this.backgroundColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kCardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: shadowColor.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: backgroundColor ?? cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardBorderRadius),
          side:
              showBorder
                  ? BorderSide(color: subtleBorderColor, width: 1)
                  : BorderSide.none,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: subtleBorderColor.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    if (titleIcon != null) ...[
                      Icon(titleIcon, size: 20, color: primaryColor),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      title!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: padding ?? const EdgeInsets.all(20.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
