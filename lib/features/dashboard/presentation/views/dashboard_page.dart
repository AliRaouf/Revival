import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/dashboard_grid.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);

    return Scaffold(
      backgroundColor: utilities.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: ResponsiveLayout(
            child: Column(
              children: [
                buildHeader(context, 1.0, utilities.isTablet),
                buildBrandBar(context, 1.0, utilities.isTablet),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: utilities.crossAxisCount,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 18.0,
                      childAspectRatio: utilities.aspectRatio,
                    ),
                    itemCount: utilities.menuItems.length,
                    itemBuilder: (context, index) {
                      final item = utilities.menuItems[index];
                      final colorIndex =
                          index % utilities.menuItemColors.length;
                      final itemColor = utilities.menuItemColors[colorIndex];

                      return DashboardGridItem(
                        title: item['title'] as String,
                        icon: item['icon'] as IconData,
                        onTap: () => context.push(item['path'] as String),
                        backgroundColor: itemColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
