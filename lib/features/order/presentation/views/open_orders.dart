import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';

import 'package:revival/features/order/presentation/views/new_orders.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';

class OrderInfo {
  final String id;
  final String invoice;
  final String order;
  final String orderCode;
  final String quote;
  final String customerName;

  OrderInfo({
    required this.id,
    required this.invoice,
    required this.order,
    required this.orderCode,
    required this.quote,
    required this.customerName,
  });
}

class OpenOrdersScreen extends StatefulWidget {
  const OpenOrdersScreen({super.key});

  @override
  State<OpenOrdersScreen> createState() => _OpenOrdersScreenState();
}

class _OpenOrdersScreenState extends State<OpenOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<OrderInfo> _filteredOrders = [];

  final List<OrderInfo> _allOrders = List.generate(
    20,
    (index) => OrderInfo(
      id: 'ORDER_${100 + index}',
      invoice: "10000$index",
      order: "${500 + index}",
      orderCode: "RC${20210 + index}",
      quote: "100$index",
      customerName:
          index % 3 == 0
              ? "Ahmed Khaled Co."
              : index % 3 == 1
              ? "Fatima Hassan Trading"
              : "Global Solutions Ltd.",
    ),
  );

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(_allOrders);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query == _searchQuery) return;

    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredOrders = List.from(_allOrders);
      } else {
        _filteredOrders =
            _allOrders.where((order) {
              return order.customerName.toLowerCase().contains(_searchQuery) ||
                  order.orderCode.toLowerCase().contains(_searchQuery) ||
                  order.order.toLowerCase().contains(_searchQuery);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: Column(
            children: [
              _buildHeader(context),

              buildBrandBar(
                context,
                MediaQuery.textScalerOf(context).textScaleFactor,
                MediaQuery.of(context).size.width > 600,
              ),
              _buildSearchBar(context),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Open Orders').tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: 'Profile',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile button tapped!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color?.withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by Name or Order Code'.tr(),
          prefixIcon: Icon(Icons.search, color: iconColor),
          suffixIcon:
              _searchQuery.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear, color: iconColor),
                    tooltip: 'Clear Search',
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                  : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ).applyDefaults(theme.inputDecorationTheme),
        style: theme.textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_allOrders.isEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.list_alt_outlined,
        title: "No Orders Yet",
        message: "When orders are created, they will appear here.",
      );
    }

    if (_filteredOrders.isEmpty && _searchQuery.isNotEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.search_off_outlined,
        title: "No Orders Found",
        message: "Try adjusting your search query.",
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 80, top: 8),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final order = _filteredOrders[index];
        return _OrderSummaryCard(order: order);
      },
    );
  }

  Widget _buildEmptyState({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final iconColor = theme.iconTheme.color?.withOpacity(0.4);
    final titleColor = theme.colorScheme.onSurface.withOpacity(0.6);
    final messageColor = theme.colorScheme.onSurface.withOpacity(0.5);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: iconColor),
            const SizedBox(height: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(color: titleColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: messageColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Create New Order',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewOrderScreen()),
        );
      },
      child: const Icon(Icons.add, size: 32),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final OrderInfo order;

  const _OrderSummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

    return Card(
      child: InkWell(
        splashColor: theme.splashColor,
        highlightColor: theme.highlightColor,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleOrderScreen(orderId: order.id),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.receipt_long,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          title: Text(
            order.customerName,

            style:
                listTileTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ) ??
                textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Code: ${order.orderCode} / Order: ${order.order}',

              style: listTileTheme.subtitleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: listTileTheme.iconColor?.withOpacity(0.8),
            size: 28,
          ),
        ),
      ),
    );
  }
}
