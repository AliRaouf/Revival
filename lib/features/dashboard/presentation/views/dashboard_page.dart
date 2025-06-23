// lib/features/dashboard/presentation/views/dashboard_page.dart
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/dashboard_grid.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/shared/utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Username'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocBuilder<LoginCubit, LoginCubitState>(
              builder: (BuildContext context, state) {
                if (state is LoginSuccess) {
                  return DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF17405E)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.data?.salesEmployeeName ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.user.data?.username ?? '',
                          style: TextStyle(
                            color: Color(0xFFD1D5DB),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            ListTile(
              onTap: () => utilities.showLanguageDialog(context),
              leading: Icon(Icons.language),
              title: Text('Language'.tr()),
            ),
            ListTile(leading: Icon(Icons.sync), title: Text('Sync Data'.tr())),
            ListTile(
              onTap: () => context.go('/'),
              leading: Icon(Icons.logout),
              title: Text('Logout'.tr()),
            ),
          ],
        ),
      ),
      backgroundColor: utilities.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: Column(
            children: [
              buildBrandBar(context, 1.0, utilities.isTablet),
              Expanded(
                child: ResponsiveLayout(
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

                      final bool comingSoon = index >= 2;

                      return DashboardGridItem(
                        title: item['title'] as String,
                        icon: item['icon'] as IconData,
                        onTap:
                            comingSoon
                                ? null
                                : () => context.push(item['path'] as String),
                        backgroundColor: itemColor,
                        comingSoon: comingSoon,
                      );
                    },
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
