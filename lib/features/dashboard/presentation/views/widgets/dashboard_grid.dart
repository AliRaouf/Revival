import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

class DashboardGridItem extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const DashboardGridItem({super.key, required this.backgroundColor, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    Utilities utilities = Utilities(context);
    return Card(
      color: backgroundColor,

      elevation: utilities.cardTheme.elevation,
      shadowColor: utilities.cardTheme.shadowColor,
      shape: utilities.cardTheme.shape,

      child: InkWell(
        onTap: onTap,
        splashColor: utilities.splashColor,
        highlightColor: utilities.highlightColor,
        child: Container(
          padding: EdgeInsets.all(utilities.isTablet ? 20 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: utilities.colorScheme.primary, size: utilities.iconSize),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,

                style: (utilities.isTablet ? utilities.textTheme.titleMedium : utilities.textTheme.titleSmall)
                    ?.copyWith(color: darkTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}