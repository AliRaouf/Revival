// lib/features/dashboard/presentation/views/dashboard_page.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/dashboard_grid.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/layout_builder.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/shared/utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerIconController;
  bool _drawerOpen = false;

  @override
  void initState() {
    super.initState();
    _drawerIconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _drawerIconController.dispose();
    super.dispose();
  }

  void _handleDrawerState(bool open) {
    setState(() {
      _drawerOpen = open;
      if (open) {
        _drawerIconController.forward();
      } else {
        _drawerIconController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);

    return BlocBuilder<LoginCubit, LoginCubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BlocBuilder<LoginCubit, LoginCubitState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Text(
                    'Welcome, {name}!'.tr(
                      namedArgs: {
                        'name': state.user.data?.salesEmployeeName ?? '',
                      },
                    ),

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return Text(
                  'Welcome, Guest!'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            actions: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _drawerIconController,
                      ),
                      tooltip: 'Open Drawer',
                      onPressed: () {
                        if (!_drawerOpen) {
                          Scaffold.of(context).openEndDrawer();
                        } else {
                          Navigator.of(context).maybePop();
                        }
                      },
                    ),
              ),
            ],
          ),
          onEndDrawerChanged: (isOpened) {
            _handleDrawerState(isOpened);
          },
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        Color(0xFF102B3A), // darker variant of primaryColor
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state is LoginSuccess
                                  ? (state.user.data?.salesEmployeeName ?? '')
                                  : 'Username'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              state is LoginSuccess
                                  ? (state.user.data?.username ?? '')
                                  : 'Guest'.tr(),
                              style: TextStyle(
                                color: Color(0xFFD1D5DB),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  onTap: () => utilities.showLanguageDialog(context),
                  leading: Icon(Icons.language, color: primaryColor),
                  title: Text('Language'.tr()),
                ),
                ListTile(
                  leading: Icon(Icons.sync, color: secondaryColor),
                  title: Text('Sync Data'.tr()),
                ),
                ListTile(
                  onTap: () => context.go('/'),
                  leading: Icon(Icons.logout, color: errorColor),
                  title: Text('Logout'.tr()),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          backgroundColor: utilities.theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Container(
              color: scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 18.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ResponsiveLayout(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: utilities.crossAxisCount,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 0.95,
                              ),
                          itemCount: utilities.menuItems.length,
                          itemBuilder: (context, index) {
                            final item = utilities.menuItems[index];
                            final colorIndex =
                                index % utilities.menuItemColors.length;
                            final itemColor =
                                utilities.menuItemColors[colorIndex];
                            final bool comingSoon = index >= 2;
                            return DashboardGridItem(
                              title: item['title'] as String,
                              icon: item['icon'] as IconData,
                              onTap:
                                  comingSoon
                                      ? null
                                      : () =>
                                          context.push(item['path'] as String),
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
          ),
        );
      },
    );
  }
}
