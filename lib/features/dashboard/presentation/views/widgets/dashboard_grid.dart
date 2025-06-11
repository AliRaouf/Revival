import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

class DashboardGridItem extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool comingSoon;

  const DashboardGridItem({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.icon,
    this.onTap,
    this.comingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);
    final bool isDisabled = comingSoon || onTap == null;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Card(
        color: backgroundColor,
        elevation: utilities.cardTheme.elevation,
        shadowColor: utilities.cardTheme.shadowColor,
        shape: utilities.cardTheme.shape,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          splashColor: utilities.splashColor,
          highlightColor: utilities.highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🎀 Ribbon-like top bar
              if (comingSoon)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Coming Soon'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // 🔲 Remaining content
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(utilities.isTablet ? 20 : 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: utilities.colorScheme.primary,
                        size: utilities.iconSize,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: (utilities.isTablet
                                ? utilities.textTheme.titleMedium
                                : utilities.textTheme.titleSmall)
                            ?.copyWith(color: darkTextColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
