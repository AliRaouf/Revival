import 'package:go_router/go_router.dart';
import 'package:revival/features/Stock/presentation/views/show_stock.dart';
import 'package:revival/features/business_partners/presentation/view/all_businesspartenars.dart';
import 'package:revival/features/business_partners/presentation/view/business_partner_view.dart';
import 'package:revival/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:revival/features/login/presentation/views/login_page.dart';
import 'package:revival/features/order/presentation/views/new_orders.dart';
import 'package:revival/features/order/presentation/views/open_orders.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashBoard(),
      ),
      GoRoute(
        path: '/order',
        builder: (context, state) => const OpenOrdersScreen(),
        routes: [
          GoRoute(
            path: 'new_order',
            builder: (context, state) => const NewOrderScreen(),
          ),
          GoRoute(
            path: 'single_order',
            builder: (context, state) => SingleOrderScreen(orderId: state.pathParameters['orderId']!),
          ),
        ],
      ),
      GoRoute(
        path: '/business_partners',
        builder: (context, state) => AllBusinessPartnerWowListPage(),
        routes: [
          GoRoute(
            path: 'new_business_partner',
            builder: (context, state) => const NewBusinessPartnerPage(),)]
      ),
      GoRoute(
        path: '/stock',
        builder: (context, state) => const WarehouseStockPage(),
      ),
    ],
  );
}